import 'package:firebase_rtdb_concept/core/init/db/exception/field_item_exceptions.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

extension FieldItemTypeExtension on FieldItem {
  /// returns true if field is a list in db.
  bool get isList {
    switch (this) {
      case FieldItem.theme:
        return false;
      case FieldItem.lang:
        return false;
      case FieldItem.patient:
        return true;
      case FieldItem.form:
        return true;
      case FieldItem.operation:
        return true;
      case FieldItem.treatment:
        return true;
    }
  }

  // returns the list types of the current field if any.
  List<FieldItem> get _childList {
    switch (this) {
      case FieldItem.patient:
        return [FieldItem.form];
      case FieldItem.form:
        return [FieldItem.operation, FieldItem.treatment];
      // ignore: no_default_cases
      default:
        return [];
    }
  }

  /// returns true if the field holds lists in the model.
  bool get isChildList => childListFields.isNotEmpty;

  /// returns parent fields of the list
  FieldItem? get parentField {
    if (isList) {
      for (final value in FieldItem.values) {
        if (value.childListFields.contains(this)) {
          return value;
        }
      }
    }
    return null;
  }

  /// returns the list types of the current field if there is any.
  /// provided items must be a list. isList must be true
  List<FieldItem> get childListFields {
    final children = _childList;
    if (children.map((child) => child.isList).toList().contains(false)) {
      throw FieldItemInvalidTypeOnList(
        msg: '$children contains non-list field',
      );
    }
    return children;
  }
}
