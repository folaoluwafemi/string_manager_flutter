import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_manager_flutter/src/data/models/string_resource.dart';
import 'package:string_manager_flutter/src/services/string_manager_service.dart';

class HiveStorage {
  late final Box<StringResource> storageBox;
  final HiveInterface _hive;

  HiveStorage({required HiveInterface hive}) : _hive = hive;

  Future<void> initialize() async {
    await _hive.initFlutter('string_path');
    if (!_hive.isAdapterRegistered(StringManager.storageTypeId)) {
      _hive.registerAdapter<StringResource>(StringResourceAdapter());
    }
    storageBox = await _hive.openBox<StringResource>(StringManager.storageKey);
  }

  StringResource? getStrings(String languageKey) {
    StringResource? stringResource = storageBox.get(languageKey);
    return stringResource;
  }

  Future<void> close() async {
    await _hive.close();
  }

  Future<void> storeStrings(StringResource resource,
      {required String languageKey}) async {
    assert(
        resource.map.isNotEmpty, 'string resource must not have an empty map');
    await storageBox.put(languageKey, resource);
  }
}
