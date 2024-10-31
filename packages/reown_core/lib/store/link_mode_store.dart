import 'package:reown_core/store/generic_store.dart';
import 'package:reown_core/store/i_generic_store.dart';

abstract class ILinkModeStore implements IGenericStore<List<String>> {
  Future<bool> update(String url);
  Future<bool> remove(String url);
  List<String> getList();
}

class LinkModeStore extends GenericStore<List<String>>
    implements ILinkModeStore {
  //
  LinkModeStore({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  static const _key = 'linkModeStore';

  @override
  Future<bool> update(String url) async {
    checkInitialized();

    try {
      final currentList = getList();
      if (!currentList.contains(url)) {
        final newList = List<String>.from([...currentList, url]);
        await storage.set(_key, {_key: newList});
        return true;
      }
    } catch (_) {
      // debugPrint('[$runtimeType] update, $_key, $e');
    }
    return false;
  }

  @override
  Future<bool> remove(String url) async {
    checkInitialized();

    try {
      final currentList = getList();
      if (currentList.contains(url)) {
        final newList = List<String>.from(currentList..remove(url));
        await storage.set(_key, {_key: newList});
        return true;
      }
    } catch (_) {
      // debugPrint('[$runtimeType] remove, $_key, $e');
    }
    return false;
  }

  @override
  List<String> getList() {
    checkInitialized();

    if (storage.has(_key)) {
      final storageValue = storage.get(_key)!;
      if (storageValue.keys.contains(_key)) {
        final currentList = (storageValue[_key] as List);
        return currentList.map((e) => '$e').toList();
      }
    }
    return [];
  }
}
