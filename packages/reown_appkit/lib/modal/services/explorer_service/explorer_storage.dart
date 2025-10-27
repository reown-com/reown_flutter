import 'dart:convert';

import 'package:reown_appkit/reown_appkit.dart';

mixin ExplorerStorage {
  Future<void> storeData<T>(T data, String key, IReownCore core) async {
    try {
      final encodedData = jsonEncode(data);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final cachedData = {'$timestamp': encodedData};
      await core.storage.set('$packageVersion//$key', cachedData);
    } catch (e) {
      core.logger.e('[$runtimeType] storeData error: $e');
    }
  }

  bool isOldData(int milliseconds) {
    final now = DateTime.now();
    final dataDate = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final difference = now.difference(dataDate);
    return difference.inMinutes >= ReownConstants.THIRTY_MINUTES;
  }

  T? getStoredDataByUri<T>(String key, IReownCore core) {
    try {
      final storageKey = '$packageVersion//$key';
      if (core.storage.has(storageKey)) {
        final cachedData = core.storage.get(storageKey)!;
        final timestamp = int.parse(cachedData.keys.first);
        if (!isOldData(timestamp)) {
          return (jsonDecode(cachedData.values.first) as T);
        }
      }
    } catch (e) {
      core.logger.e('[$runtimeType] getStoredDataByUri error: $e');
    }
    return null;
  }
}
