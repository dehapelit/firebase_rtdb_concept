import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_child_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_parent_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class RelationOperationService {
  RelationOperationService(
    this._parentRelationService,
    this._childRelationService, {
    required this.id,
    required this.item,
    required this.parentItem,
    required this.parentId,
  });

  final FirebaseRelationService<String> _parentRelationService;
  final FirebaseRelationService<bool> _childRelationService;
  final String? id;
  final FieldItem item;
  final FieldItem parentItem;
  final String? parentId;

  FirebaseParentRelationService get parentService =>
      FirebaseParentRelationService(
        service: _parentRelationService,
        item: item,
        id: id,
      );

  FirebaseChildRelationService get childService => FirebaseChildRelationService(
        service: _childRelationService,
        item: parentItem,
        id: parentId,
        child: item,
      );

  Future<void> createRelation() async {
    await parentService.set(parentId);
    await childService.set(id);
  }

  Future<void> removeRelation() async {
    await parentService.remove();
    await childService.remove();
  }
}
