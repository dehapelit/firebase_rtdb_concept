import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/field_item_config.dart';
import 'package:firebase_rtdb_concept/core/init/db/exception/field_item_exceptions.dart';

extension FieldItemTypeExtension on FieldItem {
  // returns the list types of the current field if any.
  List<FieldItem> get _childList {
    final list = <FieldItem>[];
    for (final value in FieldItem.values) {
      if (value.parent == this) {
        list.add(value);
      }
    }
    return list;
  }

  /// returns true if the field holds lists in the model.
  bool get hasChildren => childListFields.isNotEmpty;

  /// returns true if the current field has a parent field.
  bool get hasParent => parent != null;

  /// returns the list types of the current field if there is any.
  /// provided items must be a list, isList must be true
  List<FieldItem> get childListFields {
    final children = _childList;
    if (children.map((child) => child.isList).toList().contains(false)) {
      throw FieldItemInvalidTypeOnList(
        msg: '$children contains non-list field',
      );
    }
    return children;
  }

  /// return true if current field is ancestor of given child
  bool isAncestor(FieldItem child) {
    if (!child.hasParent) {
      return false;
    } else if (child.parent == this) {
      return true;
    } else {
      return isAncestor(child.parent!);
    }
  }
}
