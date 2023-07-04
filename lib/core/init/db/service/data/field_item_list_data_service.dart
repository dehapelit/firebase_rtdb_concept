import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/string_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/base_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class FieldItemListDataService<T> extends IDataService<T> {
  FieldItemListDataService(this._service, this._fieldItem);

  final IListOperationService<T> _service;
  final FieldItem _fieldItem;

  @override
  Future<T> get(String id) => _service.get(_fieldItem.path.idPath(id));

  @override
  Future<String> push(T data) => _service.push(_fieldItem.path, data);

  @override
  Future<void> remove(String id) => _service.remove(_fieldItem.path.idPath(id));

  @override
  Future<void> update(String id, T data) =>
      _service.update(_fieldItem.path.idPath(id), data);
}
