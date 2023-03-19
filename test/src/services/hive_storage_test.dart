import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:string_manager_flutter/src/data/models/string_resource.dart';
import 'package:string_manager_flutter/src/services/hive_storage.dart';

import '../data/constants/constants.dart';
import '../data/mocks/hive_mock.dart';

void main() {
  late HiveStorage hiveStorage;

  final HiveMock hiveMock = HiveMock();

  setUpAll(() {
    hiveStorage = HiveStorage(hive: hiveMock);
  });

  when(getApplicationDocumentsDirectory()).thenAnswer(
    (realInvocation) => Future.value(),
  );

  test('initializing hiveStorage completes normally', () async {
    expectLater(hiveStorage.initialize(), completes);
  });

  test('hiveStorage\'s getStrings method returns an instance of StringResource',
      () {
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
