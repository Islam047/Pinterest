import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const dbName = "dog_box";

  static final Box _box = Hive.box(dbName);
  // #setDataHiveService
  static Future<void> setData<T>(StorageKey key, T value) async {
    await _box.put(key.name, value);
  }
  // #readDataHiveService
  static T readData<T>(StorageKey key, {T? defaultValue}) {
    return _box.get(key.name, defaultValue: defaultValue);
  }
  // #removeDataHiveService
  static Future<void> removeData(StorageKey key) async {
    await _box.delete(key.name);
  }
  // #clearataHiveService
  static Future<void> clear() async {
    await _box.clear();
  }
}

// #storageKeysHiveService
enum StorageKey {
  page,userInfo,photo,
}