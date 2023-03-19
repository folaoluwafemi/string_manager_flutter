import 'package:flutter/cupertino.dart';

import '../../../string_manager_flutter.dart';

class Constants {
  static const String stringStorageKey = 'StringManager';
  static const String languageStorageKey = 'languageKey';
  static const String languageStorageId = 'languageKey';
  static const int stringTypeId = 200;
}

bool checkListValueEquality(List list1, list2) {
  bool equal = false;
  for (int i = 0; i < list1.length; i++) {
    equal = list1[i] == list2[i];
  }
  return equal;
}

class NewWidget extends StatelessWidget {
  const NewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StringManagerProvider(
      stringManager: StringManager(language: 'en'),
      child: Container(),
    );
  }
}

class StringManagerProvider extends InheritedWidget {
  final StringManager stringManager;

  const StringManagerProvider({
    super.key,
    required this.stringManager,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is StringManagerProvider &&
        stringManager.language != oldWidget.stringManager.language;
  }

  static StringManagerProvider of(BuildContext context) {
    //if you get a null error it means there's no string manager provider as an
    //ancestor widget
    return context.dependOnInheritedWidgetOfExactType<StringManagerProvider>()!;
  }
}

extension StringManagerProviderExtension on BuildContext {
  StringManager get str => StringManagerProvider.of(this).stringManager;
}
