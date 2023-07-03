import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/string_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/base_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_list_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class FireBaseDataService<T extends IJsonModel> extends IDataService<T> {
  FireBaseDataService(this._service, this._fieldItem)
      : assert(
          _fieldItem.isValidType<T>(),
          'Invalid Type on FireBaseDataService.',
        ),
        assert(
          _fieldItem.isList,
          'Provided item must be a list field.',
        );

  final FirebaseListOperationService _service;
  final FieldItem _fieldItem;

  @override
  Future<T> get(String id) async {
    final dataMap = await _service.get(_fieldItem.path.idPath(id));
    return _fieldItem.fromJson(dataMap);
  }

  @override
  Future<String> push(T data) async {
    final id = await _service.push(
      _fieldItem.path,
      data.toJson(),
    );
    return id;
  }

  @override
  Future<void> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, T data) async {
    await _service.update(
      _fieldItem.path.idPath(id),
      data.toJson(),
    );
  }
}
