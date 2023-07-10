import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/field_item_config.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/data_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_list_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/relation_operation_service.dart';

class FieldItemDataRelationOperation<T extends IJsonModel> {
  FieldItemDataRelationOperation(
    this._service,
    this._parentRelationService,
    this._childRelationService,
  )   : assert(
          FieldItem.getItemFromType<T>() != null,
          'Provided T is not defined as a FieldItem',
        ),
        _item = FieldItem.getItemFromType<T>()!;

  final IListOperationService<JsonData> _service;
  final FirebaseRelationService<String> _parentRelationService;
  final FirebaseRelationService<bool> _childRelationService;
  final FieldItem _item;

  FieldItemListDataService<T> _dataService(FieldItem item) =>
      FieldItemListDataService<T>(_service, item);
  RelationOperationService get _relationService =>
      RelationOperationService(_parentRelationService, _childRelationService);

  Future<List<Data<T>>> get({
    required String parentId,
    required FieldItem parentItem,
  }) async {
    assert(
      parentItem.isAncestor(_item),
      'Provided item must be an ancestor of given child item',
    );
    final ids = await _relationService.getChildIdsFromParent(
      parentId,
      parentItem,
      _item,
    );
    final dataList = <Data<T>>[];
    for (final id in ids) {
      final data = await _dataService(_item).get(id);
      dataList.add(Data(id: id, data: data));
    }
    return dataList;
  }

  Future<String> push({
    required String parentId,
    required T data,
  }) async {
    assert(_item.hasParent, 'Item must have a parent');
    //push data to the db
    final id = await _dataService(_item).push(data);
    //set relation between parent and child field
    await _relationService.createRelation(
      _item.parent!,
      _item,
      parentId,
      id,
    );

    return id;
  }

  Future<List<String>> pushAll({
    required String parentId,
    required List<T> dataList,
  }) async {
    final ids = <String>[];
    for (final data in dataList) {
      final id = await push(parentId: parentId, data: data);
      ids.add(id);
    }
    return ids;
  }

  /// Removes item, relations and descendants
  Future<void> remove({
    required String id,
  }) =>
      _removeSearch(id: id, item: _item);

  // Recursive remove operation
  Future<void> _removeSearch({
    required String id,
    required FieldItem item,
  }) async {
    //if there are children then remove each child recursively
    if (item.hasChildren) {
      for (final child in item.childListFields) {
        final ids =
            await _relationService.getChildIdsFromParent(id, item, child);
        for (final childId in ids) {
          await _removeSearch(id: childId, item: child);
        }
      }
    }
    //if there is a parent then remove the relation
    if (item.hasParent) {
      final parentId = await _relationService.getParentIdFromChild(id, item);
      if (parentId != null) {
        //remove relation between parent and child field
        await _relationService.removeRelation(
          item.parent!,
          item,
          parentId,
          id,
        );
      }
    }
    //remove item
    await _dataService(item).remove(id);
  }
}
