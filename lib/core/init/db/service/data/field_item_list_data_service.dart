import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/field_item_config.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/string_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/data_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/base_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';

class FieldItemListDataService<T extends IJsonModel> extends IDataService<T> {
  FieldItemListDataService(this._service, this._fieldItem);

  final IListOperationService<JsonData> _service;
  final FieldItem _fieldItem;

  T? _fromJson(JsonData? data) =>
      data == null ? null : _fieldItem.fromJson<T>(data);

  @override
  Future<List<Data<T>>> getAll() async {
    final dataMap = await _service.getAll(_fieldItem.path);
    return dataMap
        .map((data) => Data(id: data.id, data: _fromJson(data.data)))
        .toList();
  }

  @override
  Future<T?> get(String id) async {
    final dataMap = await _service.get(_fieldItem.path.idPath(id));
    return _fromJson(dataMap);
  }

  @override
  Future<String> push(T data) => _service.push(_fieldItem.path, data.toJson());

  @override
  Future<void> remove(String id) => _service.remove(_fieldItem.path.idPath(id));

  @override
  Future<void> update(String id, T data) =>
      _service.update(_fieldItem.path.idPath(id), data.toJson());
}
