import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_child_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_parent_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class RelationOperationService {
  RelationOperationService(
    this._parentRelationService,
    this._childRelationService,
  );

  final FirebaseRelationService<String> _parentRelationService;
  final FirebaseRelationService<bool> _childRelationService;

  FirebaseParentRelationService _getParentService(FieldItem item, String? id) =>
      FirebaseParentRelationService(
        service: _parentRelationService,
        item: item,
        id: id,
      );

  FirebaseChildRelationService _getChildService(
    FieldItem item,
    String? id,
    FieldItem childItem,
  ) =>
      FirebaseChildRelationService(
        service: _childRelationService,
        item: item,
        id: id,
        child: childItem,
      );

  Future<void> createRelation(
    FieldItem parentItem,
    FieldItem childItem,
    String? parentId,
    String? childId,
  ) async {
    await _getParentService(childItem, childId).set(parentId);
    await _getChildService(parentItem, parentId, childItem).set(childId);
  }

  Future<void> removeRelation(
    FieldItem parentItem,
    FieldItem childItem,
    String? parentId,
    String? childId,
  ) async {
    await _getParentService(childItem, childId).remove();
    await _getChildService(parentItem, parentId, childItem).remove();
  }

  Future<List<String>> getChildIdsFromParent(
    String rootId,
    FieldItem rootItem,
    FieldItem childItem,
  ) async {
    //return id if current item is childItem
    if (rootItem == childItem) {
      return [rootId];
    }
    //create list and fill it with recursive calls
    final idList = <String>[];
    for (final child in rootItem.childListFields) {
      //search if current child is ancestor of childItem
      if (child.isAncestor(childItem)) {
        final ids = await _getChildService(rootItem, rootId, child).get();
        for (final id in ids) {
          final subList = await getChildIdsFromParent(id, child, childItem);
          idList.addAll(subList);
        }
      }
    }
    return idList;
  }
}
