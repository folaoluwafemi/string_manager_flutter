import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_manager_flutter/src/data/constants/constants.dart';
import 'package:string_manager_flutter/src/data/models/string_resource.dart';

class HiveStorage {
  Box<StringResource>? _storageBox;
  Box<String>? _languageBox;
  final HiveInterface _hive;

  HiveStorage({required HiveInterface hive}) : _hive = hive;

  @protected
  Future<void> initializeStorage(String path) async {
    // _hive.initFlutter(path);
  }

  Future<void> initialize() async {
    await initializeStorage('string_path');
    if (!_hive.isAdapterRegistered(Constants.stringTypeId)) {
      _hive.registerAdapter<StringResource>(StringResourceAdapter());
    }
    _storageBox ??= await _hive.openBox<StringResource>(
      Constants.stringStorageKey,
    );
    _languageBox ??= await _hive.openBox<String>('languageKey');
  }

  StringResource? getStrings(String languageKey) {
    StringResource? stringResource = _storageBox?.get(languageKey);
    return stringResource;
  }

  Future<void> close() async {
    await _languageBox?.close();
    await _storageBox?.close();
    await _hive.close();
  }

  String? getStorageLanguage() {
    return _languageBox?.get(Constants.languageStorageId);
  }

  Future<void> setStorageLanguage(String language) async {
    await _languageBox?.put(Constants.languageStorageKey, language);
  }

  Future<void> storeStrings(
    StringResource resource, {
    required String languageKey,
  }) async {
    assert(
        resource.map.isNotEmpty, 'string resource must not have an empty map');
    await _storageBox?.put(languageKey, resource);
  }
}
