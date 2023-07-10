import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/relation_folder_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/base_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/relation_folder.dart';

abstract class IFieldRelationService<T> {
  IFieldRelationService({
    required this.relation,
    required this.service,
    required this.item,
    required this.id,
  });

  final RelationFolder relation;
  final IRelationService<T> service;
  final FieldItem item;
  final String? id;

  String get path => relation.getPath(item: item, id: id);
}
