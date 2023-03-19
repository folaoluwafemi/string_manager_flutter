import 'package:flutter_test/flutter_test.dart';
import 'package:string_manager_flutter/src/data/models/string_resource.dart';
import 'package:string_manager_flutter/src/services/hive_storage.dart';

import '../data/constants/constants.dart';
import '../data/mocks/hive_mock.dart';

void main() {
  late HiveStorage hiveStorage;

  final HiveMock hiveMock = HiveMock();

  setUpAll(() async {
    hiveStorage = HiveStorage(hive: hiveMock);
  });

  test('initializing hiveStorage completes normally', () async {
    // when(hiveMock.initFlutter()).thenAnswer((realInvocation) => Future.value());
    expectLater(() => hiveStorage.initialize(), returnsNormally);
  });

  test('hiveStorage\'s getStrings method returns an instance of StringResource',
      () async {
    expect(hiveStorage.getStrings('en'), isA<StringResource>());
  });

  test('storing a string resource with an map resource returns normally', () {
    expect(
        () => hiveStorage.storeStrings(
              StringResource(resource: resourceMap),
              languageKey: 'en',
            ),
        returnsNormally);
  });
  test('storing a string resource with an empty map resource returns error',
      () {
    expect(
      () => hiveStorage.storeStrings(
        StringResource(),
        languageKey: 'en',
      ),
      throwsAssertionError,
    );
  });
}
