import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/coinbase_service/utils/coinbase_utils.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/native_app_data.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/redirect.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/request_params.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_storage.dart';
import 'package:reown_appkit/modal/services/phantom_service/utils/phantom_utils.dart';
import 'package:reown_appkit/modal/services/solflare_service/utils/solflare_utils.dart';
import 'package:reown_appkit/modal/services/uri_service/i_url_utils.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/debouncer.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/api_response.dart';
import 'package:reown_appkit/reown_appkit.dart';

const int _defaultEntriesCount = 48;

class ExplorerService with ExplorerStorage implements IExplorerService {
  IUriService get _uriService => GetIt.I<IUriService>();

  final http.Client _client;
  final String _referer;

  late RequestParams _requestParams;
  late final IReownCore _core;

  @override
  String get projectId => _core.projectId;

  @override
  ValueNotifier<bool> initialized = ValueNotifier(false);

  @override
  ValueNotifier<int> totalListings = ValueNotifier(0);

  List<ReownAppKitModalWalletInfo> _listings = [];
  @override
  ValueNotifier<List<ReownAppKitModalWalletInfo>> listings = ValueNotifier([]);

  final _debouncer = Debouncer(milliseconds: 300);

  String? _currentSearchValue;
  @override
  String get searchValue => _currentSearchValue ?? '';

  @override
  ValueNotifier<bool> isSearching = ValueNotifier(false);

  @override
  Set<String>? includedWalletIds;
  String? get _includedWalletsParam {
    final includedIds = (includedWalletIds ?? <String>{});
    return includedIds.isNotEmpty ? includedIds.join(',') : null;
  }

  @override
  Set<String>? excludedWalletIds;
  String? get _excludedWalletsParam {
    final excludedIds = (excludedWalletIds ?? <String>{})
      ..addAll(_installedWalletIds)
      ..addAll(featuredWalletIds ?? {});
    return excludedIds.isNotEmpty ? excludedIds.join(',') : null;
  }

  @override
  Set<String>? featuredWalletIds;
  String? get _featuredWalletsParam {
    final featuredIds = Set.from(featuredWalletIds ?? {});
    featuredIds.removeWhere((e) => _installedWalletIds.contains(e));
    return featuredIds.isNotEmpty ? featuredIds.join(',') : null;
  }

  Set<String> _installedWalletIds = <String>{};
  String? get _installedWalletsParam {
    return _installedWalletIds.isNotEmpty
        ? _installedWalletIds.join(',')
        : null;
  }

  int _currentWalletsCount = 0;
  bool _canPaginate = true;
  @override
  bool get canPaginate => _canPaginate;

  Set<String> _chains = {};
  late final Map<String, RequiredNamespace> _namespaces;
  late final List<ReownAppKitModalWalletInfo> _customWallets;
  Map<String, String> _apiHeaders = {};

  ExplorerService({
    required IReownCore core,
    required String referer,
    this.featuredWalletIds,
    this.includedWalletIds,
    this.excludedWalletIds,
    Map<String, RequiredNamespace> namespaces = const {},
    List<ReownAppKitModalWalletInfo> customWallets = const [],
  }) : _core = core,
       _referer = referer,
       _namespaces = namespaces,
       _customWallets = customWallets,
       _client = http.Client();

  @override
  Future<void> init() async {
    if (initialized.value) {
      return;
    }

    final bundleId = await ReownCoreUtils.getPackageName();
    _apiHeaders = CoreUtils.getAPIHeaders(_core.projectId, _referer, bundleId);

    if ((includedWalletIds ?? {}).isNotEmpty) {
      featuredWalletIds = {};
      excludedWalletIds = {};
    }

    _chains = NamespaceUtils.getChainIdsFromRequiredNamespaces(
      requiredNamespaces: _namespaces,
    ).map((chainId) => NamespaceUtils.getNamespaceFromChain(chainId)).toSet();

    // TODO ideally we should call this at every opening to be able to detect newly installed wallets.
    if (!kIsWeb) {
      List<NativeAppData> nativeData = await _fetchNativeAppData();
      if ((includedWalletIds ?? {}).isNotEmpty) {
        nativeData = List<NativeAppData>.from(
          nativeData.where((e) => includedWalletIds!.contains(e.id)),
        );
      }
      final installed = (await nativeData.getInstalledApps())
          .where((e) => !(excludedWalletIds ?? {}).contains(e.id))
          .toList();
      _installedWalletIds = Set<String>.from(installed.map((e) => e.id));
    }

    await _fetchInitialWallets();

    initialized.value = true;
  }

  Future<void> _fetchInitialWallets() async {
    totalListings.value = 0;
    final allListings = await Future.wait([
      _loadCustomWallets(),
      _fetchInstalledListings(),
      _fetchFeaturedListings(),
      _fetchOtherListings(),
    ]);

    _listings = [
      ...allListings[0],
      ...allListings[1].sortByFeaturedIds(featuredWalletIds),
      ...allListings[2].sortByFeaturedIds(featuredWalletIds),
      ...allListings[3].sortByFeaturedIds(featuredWalletIds),
    ];
    listings.value = _listings;

    if (_listings.length < _defaultEntriesCount) {
      _canPaginate = false;
    }

    await _getRecentWalletAndOrder();
  }

  Future<List<ReownAppKitModalWalletInfo>> _loadCustomWallets() async {
    List<ReownAppKitModalWalletInfo> customWallets = [];
    for (var customWallet in _customWallets) {
      final listing = customWallet.listing.copyWith(
        isTopWallet: null,
        badgeType: null,
      );
      customWallet = customWallet.copyWith(listing: listing);
      final installed = await _uriService.isInstalled(
        customWallet.listing.mobileLink,
      );
      if (installed || customWallet.listing.webappLink != null) {
        customWallet = customWallet.copyWith(installed: true);
        customWallets.add(customWallet);
      }
    }
    return customWallets;
  }

  Future<void> _getRecentWalletAndOrder() async {
    ReownAppKitModalWalletInfo? walletInfo;
    final storedData = getStoredDataByUri<Map<String, dynamic>>(
      'connectedWallet',
      _core,
    );
    if (storedData != null) {
      walletInfo = ReownAppKitModalWalletInfo.fromJson(storedData);
      if (walletInfo.installed) {
        await _updateRecentWallet(walletInfo);
      }
    }
  }

  @override
  Future<void> paginate() async {
    if (!canPaginate) return;
    _requestParams = _requestParams.nextPage();
    final newListings = await _fetchListings(
      params: _requestParams,
      updateCount: false,
      debugString: 'paginate',
    );
    _listings = [..._listings, ...newListings];
    listings.value = _listings;
    if (newListings.length < _currentWalletsCount) {
      _canPaginate = false;
    } else {
      _currentWalletsCount = newListings.length;
    }
  }

  Future<List<NativeAppData>> _fetchNativeAppData() async {
    final uri = Platform.isIOS
        ? Uri.parse('${UrlConstants.apiService}/getIosData')
        : Uri.parse('${UrlConstants.apiService}/getAndroidData');

    final storedData = getStoredDataByUri<List>('nativeData', _core);
    if (storedData != null) {
      _core.logger.d('[$runtimeType] serving cached NativeData');
      return storedData.map((e) => NativeAppData.fromJson(e)).toList();
    }

    _core.logger.d('[$runtimeType] fetching new NativeData');
    try {
      final response = await _client.get(uri, headers: _apiHeaders);
      if (response.statusCode == 200 || response.statusCode == 202) {
        final apiResponse = ApiResponse<NativeAppData>.fromJson(
          jsonDecode(response.body),
          (json) => NativeAppData.fromJson(json),
        );

        final completeResponse = [
          NativeAppData(
            id: CoinbaseUtils.defaultListingData.id,
            schema: Platform.isAndroid
                ? CoinbaseUtils.defaultListingData.rdns
                : CoinbaseUtils.defaultListingData.mobileLink,
          ),
          NativeAppData(
            id: PhantomUtils.defaultListingData.id,
            schema: Platform.isAndroid
                ? PhantomUtils.defaultListingData.rdns
                : PhantomUtils.defaultListingData.mobileLink,
          ),
          NativeAppData(
            id: SolflareUtils.defaultListingData.id,
            schema: Platform.isAndroid
                ? SolflareUtils.defaultListingData.rdns
                : SolflareUtils.defaultListingData.mobileLink,
          ),
          ...apiResponse.data,
        ];

        await storeData<List<NativeAppData>>(
          completeResponse,
          'nativeData',
          _core,
        );

        return completeResponse;
      } else {
        return <NativeAppData>[];
      }
    } catch (e) {
      _core.logger.e(
        '[$runtimeType] error fetching native data $uri',
        error: e,
      );
      return [];
    }
  }

  Future<List<ReownAppKitModalWalletInfo>> _fetchInstalledListings() async {
    final storedData = getStoredDataByUri<List>('installedWallets', _core);
    if (storedData != null) {
      _core.logger.d('[$runtimeType] serving cached installed wallets');
      return storedData
          .map((e) => ReownAppKitModalWalletInfo.fromJson(e))
          .toList();
    }

    _core.logger.d('[$runtimeType] fetching new installed wallets');
    final pType = PlatformUtils.getPlatformType();
    if (pType != PlatformType.mobile) {
      return [];
    }
    if (_installedWalletIds.isEmpty) {
      return [];
    }

    // I query with include set as my installed wallets
    final params = RequestParams(
      page: 1,
      entries: _installedWalletIds.length,
      include: _installedWalletsParam,
    );
    // this query gives me a count of installedWalletsParam.length
    final installed = await _fetchListings(
      params: params,
      debugString: 'installed',
    );
    _core.logger.d('[$runtimeType] installed wallets: ${installed.length}');

    final completeResponse = List<ReownAppKitModalWalletInfo>.from(
      installed.setInstalledFlag(),
    );

    if (completeResponse.isNotEmpty) {
      await storeData<List<ReownAppKitModalWalletInfo>>(
        completeResponse,
        'installedWallets',
        _core,
      );
    }

    return completeResponse;
  }

  Future<List<ReownAppKitModalWalletInfo>> _fetchFeaturedListings() async {
    final storedData = getStoredDataByUri<List>('featuredWallets', _core);
    if (storedData != null) {
      _core.logger.d('[$runtimeType] serving cached featured wallets');
      return storedData
          .map((e) => ReownAppKitModalWalletInfo.fromJson(e))
          .toList();
    }

    if ((_featuredWalletsParam ?? '').isEmpty) {
      return [];
    }
    final params = RequestParams(
      page: 1,
      entries: _featuredWalletsParam!.split(',').length,
      include: _featuredWalletsParam,
    );
    final completeResponse = await _fetchListings(
      params: params,
      debugString: 'featured',
    );

    await storeData<List<ReownAppKitModalWalletInfo>>(
      completeResponse,
      'featuredWallets',
      _core,
    );

    return completeResponse;
  }

  Future<List<ReownAppKitModalWalletInfo>> _fetchOtherListings() async {
    _requestParams = RequestParams(
      page: 1,
      entries: _defaultEntriesCount,
      include: _includedWalletsParam,
      exclude: _excludedWalletsParam,
    );
    return await _fetchListings(params: _requestParams, debugString: 'other');
  }

  Future<List<ReownAppKitModalWalletInfo>> _fetchListings({
    RequestParams? params,
    bool updateCount = true,
    String debugString = '',
  }) async {
    params = params?.copyWith(chains: _chains.join(','));
    final baseUri = '${UrlConstants.apiService}/getWallets';
    final uri = Uri.parse(baseUri).replace(queryParameters: params?.toJson());
    _core.logger.d('[$runtimeType] fetch new $debugString with uri $uri');

    // final encoded = utf8.encode(jsonEncode(params!.toJson()));
    // final storeKey = base64.encode(encoded);

    // final storedData = getStoredDataByUri<Map<String, dynamic>>(
    //   storeKey,
    //   _core,
    // );
    // if (storedData != null) {
    //   final apiResponse = ApiResponse<AppKitModalWalletListing>.fromJson(
    //     storedData,
    //     (json) => AppKitModalWalletListing.fromJson(
    //       json as Map<String, dynamic>? ?? {},
    //     ),
    //   );
    //   if (updateCount) {
    //     totalListings.value += apiResponse.count;
    //   }

    //   return apiResponse.data
    //       .where((a) {
    //         return a.mobileLink != null ||
    //             a.id == CoinbaseUtils.walletId ||
    //             a.id == PhantomUtils.walletId ||
    //             a.id == SolflareUtils.walletId;
    //       })
    //       .toList()
    //       .toAppKitWalletInfo();
    // }

    try {
      final response = await _client.get(uri, headers: _apiHeaders);
      if (response.statusCode == 200 || response.statusCode == 202) {
        final apiResponse = ApiResponse<AppKitModalWalletListing>.fromJson(
          jsonDecode(response.body),
          (json) => AppKitModalWalletListing.fromJson(
            json as Map<String, dynamic>? ?? {},
          ),
        );
        if (updateCount) {
          totalListings.value += apiResponse.count;
        }

        // await storeData<Map<String, dynamic>>(
        //   apiResponse.toJson(),
        //   storeKey,
        //   _core,
        // );

        return apiResponse.data
            .where((a) {
              return a.mobileLink != null ||
                  a.id == CoinbaseUtils.walletId ||
                  a.id == PhantomUtils.walletId ||
                  a.id == SolflareUtils.walletId;
            })
            .toList()
            .toAppKitWalletInfo();
      } else {
        return <ReownAppKitModalWalletInfo>[];
      }
    } catch (e) {
      _core.logger.e('[$runtimeType] error fetching listings: $uri', error: e);
      return [];
    }
  }

  @override
  Future<void> storeConnectedWallet(
    ReownAppKitModalWalletInfo? walletInfo,
  ) async {
    if (walletInfo == null) return;

    final walletData = walletInfo.copyWith(installed: true, recent: true);
    await storeData<Map<String, dynamic>>(
      walletData.toJson(),
      'connectedWallet',
      _core,
    );
    await _updateRecentWallet(walletInfo);
    _core.logger.d(
      '[$runtimeType] storeConnectedWallet ${walletData.toJson()}',
    );
  }

  @override
  ReownAppKitModalWalletInfo? getConnectedWallet() {
    final storedData = getStoredDataByUri<Map<String, dynamic>>(
      'connectedWallet',
      _core,
    );
    if (storedData != null) {
      return ReownAppKitModalWalletInfo.fromJson(storedData);
    }

    return null;
  }

  Future<void> _updateRecentWallet(ReownAppKitModalWalletInfo? wallet) async {
    try {
      final currentListings = List<ReownAppKitModalWalletInfo>.from(
        _listings.map((e) => e.copyWith(recent: false)).toList(),
      );
      final walletData = wallet!.copyWith(recent: true, installed: true);

      final position = currentListings.indexWhere(
        (e) => e.listing.id == walletData.listing.id,
      );
      if (position >= 0) {
        currentListings.removeWhere(
          (e) => e.listing.id == walletData.listing.id,
        );
      }
      if (walletData.listing.id != '0000000000000001') {
        // is web-wallet
        currentListings.insert(0, walletData);
      }

      _listings = currentListings;
      listings.value = _listings;
    } catch (e, s) {
      _core.logger.e(
        '[$runtimeType] error updating recent wallet: $e',
        stackTrace: s,
      );
    }
  }

  @override
  void search({String? query}) async {
    if (query == null || query.isEmpty) {
      _currentSearchValue = null;
      listings.value = _listings;
      return;
    }

    final q = query.toLowerCase();
    await _searchListings(query: q);
  }

  Future<void> _searchListings({String? query}) async {
    isSearching.value = true;

    final includedIds = (includedWalletIds ?? <String>{});
    final include = includedIds.isNotEmpty ? includedIds.join(',') : null;
    final excludedIds = (excludedWalletIds ?? <String>{});
    final exclude = excludedIds.isNotEmpty ? excludedIds.join(',') : null;

    _currentSearchValue = query;
    List<ReownAppKitModalWalletInfo> newListings = await _fetchListings(
      params: RequestParams(
        page: 1,
        entries: 100,
        search: _currentSearchValue,
        include: include,
        exclude: exclude,
      ),
      updateCount: false,
      debugString: 'search',
    );

    if (_currentSearchValue != null) {
      final samples = (await _loadCustomWallets()).where(
        (e) => e.listing.name.toLowerCase().contains(query!.toLowerCase()),
      );
      newListings = [...samples, ...newListings];
    }

    listings.value = newListings;
    _debouncer.run(() => isSearching.value = false);
  }

  @override
  Future<ReownAppKitModalWalletInfo?> getCoinbaseWalletObject() async {
    if (kIsWeb) {
      return null;
    }

    final storedData = getStoredDataByUri<Map<String, dynamic>>(
      'coinbaseWallet',
      _core,
    );
    if (storedData != null) {
      _core.logger.d('[$runtimeType] serving cached Coinbase Wallet');
      return ReownAppKitModalWalletInfo.fromJson(storedData);
    }

    _core.logger.d('[$runtimeType] fetching new Coinbase Wallet');
    final results = await _fetchListings(
      params: RequestParams(
        page: 1,
        entries: 1,
        include: CoinbaseUtils.walletId,
      ),
      updateCount: false,
      debugString: 'coinbase',
    );

    if (results.isNotEmpty) {
      final serviceData = ReownAppKitModalWalletInfo.fromJson(
        results.first.toJson(),
      );
      final mobileLink = CoinbaseUtils.defaultListingData.mobileLink;
      final rdns = CoinbaseUtils.defaultListingData.rdns;
      final linkMode = CoinbaseUtils.defaultListingData.linkMode;
      final installed = Platform.isAndroid
          ? await _uriService.isInstalled(rdns)
          : await _uriService.isInstalled(mobileLink);
      final coinbaseObject = serviceData.copyWith(
        listing: serviceData.listing.copyWith(
          mobileLink: mobileLink,
          linkMode: linkMode,
        ),
        installed: installed,
      );

      await storeData<Map<String, dynamic>>(
        coinbaseObject.toJson(),
        'coinbaseWallet',
        _core,
      );

      return coinbaseObject;
    }
    return null;
  }

  @override
  Future<ReownAppKitModalWalletInfo?> getPhantomWalletObject() async {
    if (kIsWeb) {
      return null;
    }

    final storedData = getStoredDataByUri<Map<String, dynamic>>(
      'phantomWallet',
      _core,
    );
    if (storedData != null) {
      _core.logger.d('[$runtimeType] serving cached Phantom Wallet');
      return ReownAppKitModalWalletInfo.fromJson(storedData);
    }

    _core.logger.d('[$runtimeType] fetching new Phantom Wallet');
    final results = await _fetchListings(
      params: RequestParams(
        page: 1,
        entries: 1,
        include: PhantomUtils.walletId,
      ),
      updateCount: false,
      debugString: 'phantom',
    );

    if (results.isNotEmpty) {
      final serviceData = ReownAppKitModalWalletInfo.fromJson(
        results.first.toJson(),
      );
      final mobileLink = PhantomUtils.defaultListingData.mobileLink;
      final rdns = PhantomUtils.defaultListingData.rdns;
      final linkMode = PhantomUtils.defaultListingData.linkMode;
      final installed = Platform.isAndroid
          ? await _uriService.isInstalled(rdns)
          : await _uriService.isInstalled(mobileLink);
      final phantomObject = serviceData.copyWith(
        listing: serviceData.listing.copyWith(
          mobileLink: mobileLink,
          linkMode: linkMode,
        ),
        installed: installed,
      );

      await storeData<Map<String, dynamic>>(
        phantomObject.toJson(),
        'phantomWallet',
        _core,
      );

      return phantomObject;
    }
    return null;
  }

  @override
  Future<ReownAppKitModalWalletInfo?> getSolflareWalletObject() async {
    if (kIsWeb) {
      return null;
    }

    final storedData = getStoredDataByUri<Map<String, dynamic>>(
      'solflareWallet',
      _core,
    );
    if (storedData != null) {
      _core.logger.d('[$runtimeType] serving cached Solflare Wallet');
      return ReownAppKitModalWalletInfo.fromJson(storedData);
    }

    _core.logger.d('[$runtimeType] fetching new Solflare Wallet');
    final results = await _fetchListings(
      params: RequestParams(
        page: 1,
        entries: 1,
        include: SolflareUtils.walletId,
      ),
      updateCount: false,
      debugString: 'solflare',
    );

    if (results.isNotEmpty) {
      final serviceData = ReownAppKitModalWalletInfo.fromJson(
        results.first.toJson(),
      );
      final mobileLink = SolflareUtils.defaultListingData.mobileLink;
      final rdns = SolflareUtils.defaultListingData.rdns;
      final linkMode = SolflareUtils.defaultListingData.linkMode;
      final installed = Platform.isAndroid
          ? await _uriService.isInstalled(rdns)
          : await _uriService.isInstalled(mobileLink);
      final solflareObject = serviceData.copyWith(
        listing: serviceData.listing.copyWith(
          mobileLink: mobileLink,
          linkMode: linkMode,
        ),
        installed: installed,
      );

      await storeData<Map<String, dynamic>>(
        solflareObject.toJson(),
        'solflareWallet',
        _core,
      );

      return solflareObject;
    }
    return null;
  }

  @override
  String getWalletImageUrl(String imageId) {
    if (imageId.isEmpty) {
      return '';
    }
    if (imageId.startsWith('http')) {
      return imageId;
    }
    return '${UrlConstants.apiService}/getWalletImage/$imageId';
  }

  @override
  String getAssetImageUrl(String imageId) {
    if (imageId.isEmpty) {
      return '';
    }
    if (imageId.startsWith('http')) {
      return imageId;
    }
    return '${UrlConstants.apiService}/public/getAssetImage/$imageId';
  }

  @override
  WalletRedirect? getWalletRedirect(ReownAppKitModalWalletInfo? walletInfo) {
    if (walletInfo == null) return null;

    // TODO do we need the same for phantom or de we even need it for Coinbase?
    if (walletInfo.listing.id == CoinbaseUtils.defaultListingData.id) {
      return WalletRedirect(
        mobile: CoinbaseUtils.defaultListingData.mobileLink,
        linkMode: CoinbaseUtils.defaultListingData.linkMode,
        desktop: null,
        web: null,
      );
    }
    return WalletRedirect(
      mobile: walletInfo.listing.mobileLink?.trim(),
      linkMode: walletInfo.listing.linkMode?.trim(),
      desktop: walletInfo.listing.desktopLink,
      web: walletInfo.listing.webappLink,
    );
  }
}

extension on List<AppKitModalWalletListing> {
  List<ReownAppKitModalWalletInfo> toAppKitWalletInfo() {
    return map(
      (item) => ReownAppKitModalWalletInfo(
        listing: item,
        installed: false,
        recent: false,
      ),
    ).toList();
  }
}

extension on List<ReownAppKitModalWalletInfo> {
  List<ReownAppKitModalWalletInfo> sortByFeaturedIds(
    Set<String>? featuredWalletIds,
  ) {
    Map<String, dynamic> sortedMap = {};
    final auxList = List<ReownAppKitModalWalletInfo>.from(this);

    for (var id in featuredWalletIds ?? <String>{}) {
      final featured = auxList.firstWhereOrNull((e) => e.listing.id == id);
      if (featured != null) {
        auxList.removeWhere((e) => e.listing.id == id);
        sortedMap[id] = featured;
      }
    }

    return [...sortedMap.values, ...auxList];
  }

  List<ReownAppKitModalWalletInfo> setInstalledFlag() {
    return map((e) => e.copyWith(installed: true)).toList();
  }
}

extension on List<NativeAppData> {
  Future<List<NativeAppData>> getInstalledApps() async {
    final installedApps = <NativeAppData>[];
    for (var appData in this) {
      bool installed = await GetIt.I<IUriService>().isInstalled(
        appData.schema,
        id: appData.id,
      );
      if (installed) {
        installedApps.add(appData);
      }
    }
    return installedApps;
  }
}
