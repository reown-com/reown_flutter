import 'package:event/event.dart';
import 'package:reown_core/store/i_store.dart';
import 'package:reown_core/store/store_models.dart';

abstract class IGenericStore<T> {
  abstract final String version;
  abstract final String context;

  abstract final IStore storage;
  abstract final String storageKey;

  // abstract final dynamic Function(T) toJson;
  abstract final T Function(dynamic) fromJson;

  /// Emitted when a new key is added to the store.
  /// The event contains the key and the value of type [T].
  abstract final Event<StoreCreateEvent<T>> onCreate;

  /// Emitted when a key is updated in some way: overwritten, some piece changes, etc.
  /// The event contains the key and the value of type [T].
  abstract final Event<StoreUpdateEvent<T>> onUpdate;

  /// Emitted when a key is deleted from the store.
  /// The event contains the key and the value of type [T].
  abstract final Event<StoreDeleteEvent<T>> onDelete;

  /// Emitted when a key is deleted from the store because of an error
  /// The event contains the key and the error description.
  abstract final Event<StoreErrorEvent<T>> onError;

  /// Emitted when the store is persisted to storage.
  /// This event can be used as a catchall for any creations, updates, or deletions.
  abstract final Event<StoreSyncEvent> onSync;

  Future<void> init();
  bool has(String key);
  Future<void> set(String key, T value);
  T? get(String key);
  List<T> getAll();
  Future<void> delete(String key);
  Future<void> restore();
  Future<void> persist();
}
