import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/data_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_list_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/relation_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class FieldItemDataOperation<T extends IJsonModel> {
  FieldItemDataOperation(
    this._service,
    this._parentRelationService,
    this._childRelationService,
  );

  final IListOperationService<JsonData> _service;
  final FirebaseRelationService<String> _parentRelationService;
  final FirebaseRelationService<bool> _childRelationService;

  FieldItemListDataService<T> _dataService(FieldItem item) =>
      FieldItemListDataService<T>(_service, item);
  RelationOperationService get _relationService =>
      RelationOperationService(_parentRelationService, _childRelationService);

  Future<List<Data<T>>> get({
    required String parentId,
    required FieldItem parentItem,
    required FieldItem item,
  }) async {
    assert(
      parentItem.isAncestor(item),
      'Provided item must be an ancestor of given child item',
    );
    assert(
      item.isValidType<T>(),
      'Provided generic type is not valid for given item',
    );
    final ids = await _relationService.getChildIdsFromParent(
      parentId,
      parentItem,
      item,
    );
    final dataList = <Data<T>>[];
    for (final id in ids) {
      final data = await _dataService(item).get(id);
      dataList.add(Data(id: id, data: data));
    }
    return dataList;
  }

  Future<String> push({
    required String parentId,
    required FieldItem parentItem,
    required FieldItem item,
    required T data,
  }) async {
    assert(
      item.parentField == parentItem,
      'item must be a child of the parentField',
    );
    assert(
      item.isValidType<T>(),
      'Provided generic type is not valid for given item',
    );
    //push data to the db
    final id = await _dataService(item).push(data);
    //set relation between parent and child field
    await _relationService.createRelation(
      parentItem,
      item,
      parentId,
      id,
    );

    return id;
  }

  Future<void> remove({
    required String parentId,
    required FieldItem parentItem,
    required FieldItem item,
    required String id,
  }) async {
    assert(
      item.parentField == parentItem,
      'item must be a child of the parentField',
    );
    //remove relation between parent and child field
    await _relationService.removeRelation(
      parentItem,
      item,
      parentId,
      id,
    );
    //remove item
    await _dataService(item).remove(id);
  }
}
