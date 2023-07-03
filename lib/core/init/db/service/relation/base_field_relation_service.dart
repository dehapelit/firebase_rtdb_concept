import 'package:firebase_rtdb_concept/core/init/db/extensions/relation_folder_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/base_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/relation_folder.dart';

abstract class IFieldRelationService<T extends FieldItem, E> {
  IFieldRelationService({
    required this.relation,
    required this.service,
    required this.item,
    required this.id,
  });

  final RelationFolder relation;
  final IRelationService<E> service;
  final T item;
  final String? id;

  String get path => relation.getPath(item: item, id: id);
}
