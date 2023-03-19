import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_manager_flutter/src/data/constants/constants.dart';
import 'package:string_manager_flutter/src/data/models/string_resource.dart';
import 'package:string_manager_flutter/src/services/hive_storage.dart';

class HiveStorageMock extends HiveStorage {
  final HiveInterface _hive;

  Box<StringResource>? _storageBox;
  Box<String>? _languageBox;

  HiveStorageMock({
    required super.hive,
  }) : _hive = hive;

  @override
  Future<void> initialize() async {
    _hive.init('string_path');
    if (!_hive.isAdapterRegistered(Constants.stringTypeId)) {
      _hive.registerAdapter<StringResource>(StringResourceAdapter());
    }
    _storageBox ??=
        await _hive.openBox<StringResource>(Constants.stringStorageKey);
    _languageBox ??= await _hive.openBox<String>('languageKey');
  }
}
