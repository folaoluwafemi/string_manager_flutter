import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:string_manager_flutter/src/services/hive_storage.dart';

class HiveStorageMock extends Mock implements HiveStorage {
  final HiveInterface _hive;

  HiveStorageMock({
    required HiveInterface hive,
  }) : _hive = hive;

  @override
  Future<void> initializeStorage(String path) {
    _hive.init(path);
    return Future.value();
  }
}
