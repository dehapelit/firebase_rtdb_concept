import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/relation_folder_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/string_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/field_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/relation_folder.dart';

class FirebaseFieldRelationService extends FirebaseRelationService {
  factory FirebaseFieldRelationService() {
    return _singleton;
  }

  FirebaseFieldRelationService._internal();
  static final FirebaseFieldRelationService _singleton =
      FirebaseFieldRelationService._internal();

  final String _childAssertionTitle = 'Invalid child item.';

  String _getChildPath(
    Field field,
    Field child,
  ) =>
      RelationFolder.parent
          .getPath(item: field.item, id: field.id!)
          .idPath(child.item.name.idPath(child.id));

  String _getParentPath(Field field) =>
      RelationFolder.parent.getPath(item: field.item, id: field.id!);

  bool _isValidParent(Field field) => field.item.hasParent && field.id != null;

  bool _isValidChild(
    Field field,
    Field child,
  ) {
    assert(
      field.item.childListFields.contains(child.item),
      _childAssertionTitle,
    );
    return field.item.hasChildren && field.id != null;
  }

  Future<void> setParentField(Field field) async {
    if (_isValidParent(field)) {
      await setParent(
        _getParentPath(field),
        field.parentId!,
      );
    }
  }

  Future<void> setChildField<T>(
    Field field,
    Field child,
  ) async {
    if (_isValidChild(field, child)) {
      await setChild(_getChildPath(field, child));
    }
  }

  Future<void> removeParentField(Field field) async {
    if (_isValidParent(field) && field.parentId != null) {
      await removeParent(_getParentPath(field));
    }
  }

  Future<void> removeChildField(
    Field field,
    Field child,
  ) async {
    if (_isValidChild(field, child)) {
      await removeChild(_getChildPath(field, child));
    }
  }

  Future<String?> getParentFieldId(Field field) async {
    String? id;
    if (_isValidParent(field)) {
      id = await getParent(_getParentPath(field));
    }
    return id;
  }

  Future<String?> getChildFieldId(
    Field field,
    Field child,
  ) async {
    String? id;
    if (_isValidChild(field, child)) {
      id = await getChild(_getChildPath(field, child));
    }
    return id;
  }
}
