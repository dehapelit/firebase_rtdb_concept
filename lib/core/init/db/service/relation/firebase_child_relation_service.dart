import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/string_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/base_field_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/relation_folder.dart';

class FirebaseChildRelationService extends IFieldRelationService<bool> {
  FirebaseChildRelationService({
    required super.service,
    required super.item,
    required super.id,
    required this.child,
  })  : assert(
          id != null && item.childListFields.contains(child),
          'Invalid parent input.',
        ),
        super(relation: RelationFolder.children);

  final FieldItem child;

  @override
  String get path => super.path.idPath(child.name);

  Future<List<String>> get() async => service.getAll(path);

  Future<void> remove(String? childId) => service.remove(path.idPath(childId));

  Future<void> set(String? childId) => service.set(path.idPath(childId), true);
}
