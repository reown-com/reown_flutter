import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/models/public/appkit_network_info.dart';

abstract class INetworkService {
  abstract ValueNotifier<List<GridItem<ReownAppKitModalNetworkInfo>>> itemList;
  abstract ValueNotifier<bool> initialized;

  Future<void> init();

  void filterList({String? query});
}
