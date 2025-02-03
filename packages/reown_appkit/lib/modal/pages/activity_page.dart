import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/wallet_activity.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
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
  @override
  Widget build(BuildContext context) {
    return ModalNavbar(
      title: 'Activity',
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: false,
      body: Container(
        constraints: BoxConstraints(
          maxHeight: ResponsiveData.maxHeightOf(context),
        ),
        padding: const EdgeInsets.symmetric(horizontal: kPadding12),
        child: ActivityListViewBuilder(
          appKitModal: ModalProvider.of(context).instance,
        ),
      ),
    );
  }
}

class ActivityListViewBuilder extends StatefulWidget {
  ActivityListViewBuilder({required this.appKitModal, super.key});
  final IReownAppKitModal appKitModal;

  @override
  State<ActivityListViewBuilder> createState() =>
      _ActivityListViewBuilderState();
}

class _ActivityListViewBuilderState extends State<ActivityListViewBuilder> {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IReownCore get _core => widget.appKitModal.appKit!.core;

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
    final chainId = widget.appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      chainId,
    );
    _currentChain = '$namespace:$chainId';
    _currentAddress = widget.appKitModal.session!.getAddress(namespace)!;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        _loadMoreActivities();
      }
    });

    // cached items
    final cachedItems = _blockchainService.activityData?.data ?? <Activity>[];
    if (cachedItems.isNotEmpty) {
      final activityList = cachedItems.where((data) {
        return data.metadata?.chain == _currentChain &&
            (data.transfers ?? []).isNotEmpty;
      }).toList();
      _activities.addAll(activityList);
    }
    setState(() {});

    _fetchActivities();
  }

  Future<void> _fetchActivities() async {
    setState(() => _isLoadingActivities = _activities.isEmpty);

    try {
      final activityData = await _blockchainService.getHistory(
        address: _currentAddress,
        cursor: _currentCursor,
        caip2Chain: _currentChain,
      );
      _activities.clear();
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
    } catch (e) {
      _isLoadingActivities = false;
      widget.appKitModal.onModalError.broadcast(ModalError(
        'Error fetching activity',
      ));
    }
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
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    if (_isLoadingActivities && _activities.isEmpty) {
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

    if (_activities.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedIcon(
            assetPath: 'lib/modal/assets/icons/swap_horizontal.svg',
            assetColor: themeColors.foreground200,
            circleColor: themeColors.grayGlass010,
            borderColor: themeColors.grayGlass010,
            borderRadius: 8.0,
          ),
          const SizedBox.square(dimension: kPadding8),
          Text(
            'No activity yet',
            style: themeData.textStyles.paragraph500.copyWith(
              color: themeColors.foreground100,
            ),
          ),
          Text(
            'Your next transactions will appear here',
            style: themeData.textStyles.small400.copyWith(
              color: themeColors.foreground200,
            ),
          ),
          const SizedBox.square(dimension: 30.0),
        ],
      );
    }

    final groupedByYearMonth = groupBy(_activities, (Activity obj) {
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

    // final height = groupedActivities.map((entry) {
    //       if (entry.key.isNotEmpty) {
    //         // title
    //         return 28.0;
    //       } else {
    //         // transfers
    //         return kListItemHeight;
    //       }
    //     }).reduce((a, b) => a + b) +
    //     30.0;
    return ListView.builder(
      controller: _scrollController,
      // Extra space for loading indicator
      itemCount: groupedActivities.length + (_isLoadingActivities ? 1 : 0),
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
          return data.metadata?.chain == _currentChain &&
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
