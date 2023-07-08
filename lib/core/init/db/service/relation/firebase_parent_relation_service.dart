import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/base_field_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/relation_folder.dart';

class FirebaseParentRelationService extends IFieldRelationService<String> {
  FirebaseParentRelationService({
    required super.service,
    required super.item,
    required super.id,
  })  : assert(item.hasParent && id != null, 'Invalid parent input.'),
        super(relation: RelationFolder.parent);

  Future<String?> get() => service.get(path);

  Future<void> remove() => service.remove(path);

  Future<void> set(String? parentId) {
    assert(parentId != null, 'Parent id cannot be null.');
    return service.set(path, parentId!);
  }
}
