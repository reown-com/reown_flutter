import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/wallet_activity.dart';
import 'package:reown_appkit/modal/widgets/lists/activity_item.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage() : super(key: KeyConstants.activityPageKey);
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IReownCore get _core => _appKitModal.appKit!.core;
  late final IReownAppKitModal _appKitModal;

  final _scrollController = ScrollController();
  final List<Activity> _activities = [];
  String? _currentCursor;
  bool _isLoadingActivities = false;
  bool _hasMoreActivities = true;
  String _currentAddress = '';
  String _currentChain = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _appKitModal = ModalProvider.of(context).instance;
      final chainId = _appKitModal.selectedChain!.chainId;
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        chainId,
      );
      _currentChain = '$namespace:$chainId';
      _currentAddress = _appKitModal.session!.getAddress(namespace)!;

      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
          _loadMoreActivities();
        }
      });

      _fetchActivities();
    });
  }

  Future<void> _fetchActivities() async {
    setState(() => _isLoadingActivities = true);

    // Initial API request here
    final activityData = await _blockchainService.getActivity(
      address: _currentAddress,
      cursor: _currentCursor,
    );
    final newItems = activityData.data ?? <Activity>[];
    final activityList = newItems.where((data) {
      return data.metadata?.chain == _currentChain &&
          (data.transfers ?? []).isNotEmpty;
    }).toList();

    _activities.addAll(activityList);
    _isLoadingActivities = false;
    _currentCursor = activityData.next;
    _hasMoreActivities = _currentCursor != null;
    _core.logger.d(
      '[$runtimeType] fetch data, items: ${activityList.length}, cursor: $_currentCursor, _hasMoreActivities: $_hasMoreActivities',
    );
    setState(() {});
  }

  Future<void> _loadMoreActivities() async {
    if (_isLoadingActivities || !_hasMoreActivities) return;
    await _fetchActivities();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalNavbar(
      title: 'Activity',
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: false,
      body: Container(
        constraints: BoxConstraints(
          maxHeight: ((_isLoadingActivities && _activities.isEmpty) ||
                  _activities.length <= 4)
              ? 340.0
              : ResponsiveData.maxHeightOf(context),
        ),
        padding: const EdgeInsets.symmetric(horizontal: kPadding12),
        child: _ListBuilder(
          scrollController: _scrollController,
          items: _activities,
          caip2chain: _currentChain,
          isLoading: _isLoadingActivities,
        ),
      ),
    );
  }
}

class _ListBuilder extends StatefulWidget {
  const _ListBuilder({
    required this.scrollController,
    required this.items,
    required this.caip2chain,
    required this.isLoading,
  });
  final ScrollController scrollController;
  final List<Activity> items;
  final String caip2chain;
  final bool isLoading;

  @override
  State<_ListBuilder> createState() => __ListBuilderState();
}

class __ListBuilderState extends State<_ListBuilder> {
  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    if (widget.isLoading && widget.items.isEmpty) {
      final loadingList = [
        ActivityListItemLoader(),
        ActivityListItemLoader(),
        ActivityListItemLoader(),
        ActivityListItemLoader(),
        ActivityListItemLoader(),
      ]
          .map(
            (e) => Shimmer.fromColors(
              baseColor: themeColors.grayGlass100,
              highlightColor: themeColors.grayGlass025,
              child: e,
            ),
          )
          .toList();
      return ListView.builder(
        itemCount: loadingList.length,
        padding: const EdgeInsets.only(bottom: 30.0, top: 10.0),
        itemBuilder: (_, int index) {
          return Container(
            width: 1000.0,
            padding: const EdgeInsets.only(bottom: 6.0),
            child: loadingList[index],
          );
        },
      );
    }

    if (widget.items.isEmpty) {
      return Center(
        child: Text(
          'No activity found',
          style: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground100,
          ),
        ),
      );
    }

    final groupedByYearMonth = groupBy(widget.items, (Activity obj) {
      final monthName = DateFormat.MMMM().format(
        obj.metadata!.minedAt!,
      );
      return '$monthName ${obj.metadata!.minedAt!.year}';
    });

    // Flatten the grouped data for the ListView
    final groupedActivities = <MapEntry<String, List<Activity>>>[];
    groupedByYearMonth.forEach((yearMonth, objs) {
      groupedActivities.add(MapEntry(yearMonth, objs));
      groupedActivities.addAll(objs.map((obj) => MapEntry('', [obj])));
    });

    return ListView.builder(
      controller: widget.scrollController,
      // Extra space for loading indicator
      itemCount: groupedActivities.length + (widget.isLoading ? 1 : 0),
      padding: const EdgeInsets.only(bottom: 30.0),
      itemBuilder: (_, int index) {
        if (index == groupedActivities.length) {
          // Loading indicator
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        final entry = groupedActivities[index];
        if (entry.key.isNotEmpty) {
          // Display the year-month as a header
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              entry.key,
              style: themeData.textStyles.paragraph400.copyWith(
                color: themeColors.foreground200,
              ),
            ),
          );
        } else {
          // Display the object details
          final activity = entry.value.first;
          return ActivityListItem(
            activity: activity,
            onTap: () {},
          );
        }
      },
    );
  }

  // ignore: unused_element
  List<Activity> _removeNFTsFromTransfers(List<Activity> activities) {
    final activityList = activities
        .where((data) {
          return data.metadata?.chain == widget.caip2chain &&
              (data.transfers ?? []).isNotEmpty;
        })
        .toList()
        .map((a) {
          final transfers = List<Transfer>.from(
              (a.transfers ?? []).where((e) => e.fungibleInfo != null));
          return Activity(
            id: a.id,
            metadata: a.metadata,
            transfers: transfers,
          );
        })
        .where((element) {
          return (element.transfers ?? []).isNotEmpty;
        });
    return activityList.toList();
  }
}
