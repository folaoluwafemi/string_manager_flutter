import 'package:hive_flutter/hive_flutter.dart';
import 'package:string_manager_flutter/src/data/constants/constants.dart';
import 'package:string_manager_flutter/src/data/models/string_resource.dart';
import 'package:string_manager_flutter/src/services/hive_storage.dart';
import 'package:string_manager_flutter/src/services/translation_service.dart';
import 'package:translator/translator.dart';

abstract class StringManagerInterface {
  ///current language
  String _language;

  ///variable that holds all strings
  StringResource _stringResource;

  ///storage service for stringResource
  final HiveStorage _storage;

  ///translation service (uses GoogleTranslate)
  final TranslationService _translator;

  bool _initialized = false;

  StringManagerInterface({
    required String language,
    HiveInterface? hive,
    GoogleTranslator? googleTranslator,
  })  : _stringResource = StringResource(),
        _language = language,
        _storage = HiveStorage(hive: hive ?? Hive),
        _translator = TranslationService(
          translator: googleTranslator ?? GoogleTranslator(),
        );

  ///initializes the storage and gets all local strings corresponding to a
  ///if there is a cached language and a stored stringResource then it translates
  ///[_stringResource]
  Future<void> initialize() async {
    await _storage.initialize();
    _initialized = true;
    String? cachedLang = _storage.getStorageLanguage();
    if (cachedLang != null) {
      getStrings(language: cachedLang);
      if (stringResource.map.isNotEmpty) {
        await translate(from: cachedLang, to: _language);
      }
    }
  }

  ///StringManager must be initialized first
  ///getter for the current [_language]
  String get language {
    assert(_initialized, 'stringManager must be initialized');
    return _language;
  }

  ///StringManager must be initialized first
  ///getter for the [_stringResource]
  StringResource get stringResource {
    assert(_initialized, 'stringManager must be initialized');

    return _stringResource;
  }


  ///StringManager must be initialized first
  ///registers a string in the stringResource
  String reg(String text) {
    assert(_initialized, 'stringManager must be initialized');
    return _stringResource.register(text);
  }

  ///StringManager must be initialized first
  ///stores stringResource locally with to the current language
  Future<void> save() async {
    assert(_initialized, 'stringManager must be initialized');
    await _storage.storeStrings(_stringResource, languageKey: _language);
    await _storage.setStorageLanguage(_language);
  }

  ///StringManager must be initialized first
  ///sets the current stringResource to the stored one that corresponds to specific language
  ///no stringResource is available in storage then it does nothing
  void getStrings({String? language}) {
    language ??= _language;
    assert(_initialized, 'stringManager must be initialized');

    StringResource? resource = _storage.getStrings(language);
    if (resource == null) {
      return;
    }
    _stringResource = StringResource(resource: resource.map);
  }

  ///StringManager must be initialized first
  ///Closes all storage boxes and sets the stringManager to uninitialized
  Future<void> close() async {
    assert(_initialized, 'stringManager must be initialized');
    await _storage.close();
    _initialized = false;
  }

  set setLanguage(String lang) {
    _language = lang;
  }

  ///StringManager must be initialized first
  ///Tries to translates all the strings in stringResource.resource
  ///if successful it updates the current stringResource
  Future<void> translate({required String to, String? from}) async {
    assert(_initialized, 'stringManager must be initialized');
    try {
      from = from?.trim();
      StringResource resource = await _translator.translateStringResource(
        _stringResource,
        from: from ?? _language.trim(),
        to: to.trim(),
      );
      bool translationSuccessful = !(checkListValueEquality(
        _stringResource.resources,
        resource.resources,
      ));
      if (translationSuccessful) {
        _stringResource = resource;
        _language = to;
      }
    } catch (e) {
      rethrow;
    }
  }
}

class StringManager extends StringManagerInterface {
  StringManager._({
    required super.language,
  });

  static StringManager? _instance;

  ///factory singletonConstructor for all strings
  factory StringManager({required String language}) {
    _instance ??= StringManager._(language: language);
    return _instance!;
  }

  ///getter for [_instance]
  ///will not allow access if [_instance] is null
  static StringManager get instance {
    assert(_instance != null, 'Constructor wasn\'t called');
    return _instance!;
  }
}
