import 'package:hive/hive.dart';
import 'package:string_manager_flutter/src/services/string_manager_service.dart';

class StringResource {
  final Map<String, String> _resources = {};

  StringResource({Map<String, String>? resource}) {
    if (resource != null) {
      _resources.clear();
      _resources.addAll(resource);
    }
  }

  List<String> get resources => _resources.values.toList();

  Map<String, String> get map => _resources;

  String register(String resource) {
    String text = '';
    if (_resources.containsKey(resource)) {
      text = _resources[resource]!;
      return text;
    }
    _resources[resource] = resource;
    return _resources[resource]!;
  }
}

class StringResourceAdapter extends TypeAdapter<StringResource> {
  @override
  final typeId = StringManager.storageTypeId;

  @override
  StringResource read(BinaryReader reader) {
    Map<String, String> map = reader.readMap().map<String, String>(
        (key, value) => MapEntry(key.toString(), value.toString()));
    return StringResource(resource: map);
  }

  @override
  void write(BinaryWriter writer, StringResource obj) {
    writer.writeMap(obj.map);
  }
}
