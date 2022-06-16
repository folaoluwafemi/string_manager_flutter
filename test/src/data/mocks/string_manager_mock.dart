import 'package:string_manager_flutter/src/services/string_manager_service.dart';

class StringManagerMock extends StringManagerInterface {
  static const int storageTypeId = 200;
  static const String storageKey = 'StringManager';

  StringManagerMock({
    required super.language,
    super.hive,
    super.googleTranslator,
  });
}
