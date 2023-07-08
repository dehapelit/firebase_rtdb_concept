import 'package:firebase_rtdb_concept/core/init/db/exception/field_item_exceptions.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/model/form_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/operation_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/patient_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/treatment_model.dart';

extension FieldItemTypeExtension on FieldItem {
  /// returns true if field is a list in db.
  bool get isList {
    return switch (this) {
      FieldItem.patient => true,
      FieldItem.form => true,
      FieldItem.operation => true,
      FieldItem.treatment => true,
      _ => false
    };
  }

  // returns fromJson constructor for IJsonModel objects.
  T fromJson<T extends IJsonModel>(JsonData json) {
    return switch (this) {
      FieldItem.patient => Patient.fromJson(json) as T,
      FieldItem.form => FormModel.fromJson(json) as T,
      FieldItem.operation => Operation.fromJson(json) as T,
      FieldItem.treatment => Treatment.fromJson(json) as T,
      _ => throw UnimplementedError()
    };
  }

  /// returns true if type is correct.
  bool isValidType<T>() {
    return switch (this) {
      FieldItem.lang => String == T,
      FieldItem.theme => String == T,
      FieldItem.patient => Patient == T,
      FieldItem.form => FormModel == T,
      FieldItem.operation => Operation == T,
      FieldItem.treatment => Treatment == T,
    };
  }

  /// returns parent field of current item.
  FieldItem? get parentField {
    return switch (this) {
      FieldItem.form => FieldItem.patient,
      FieldItem.operation => FieldItem.form,
      FieldItem.treatment => FieldItem.form,
      _ => null
    };
  }

  // returns the list types of the current field if any.
  List<FieldItem> get _childList {
    final list = <FieldItem>[];
    for (final value in FieldItem.values) {
      if (value.parentField == this) {
        list.add(value);
      }
    }
    return list;
  }

  /// returns true if the field holds lists in the model.
  bool get hasChildren => childListFields.isNotEmpty;

  /// returns true if the current field has a parent field.
  bool get hasParent => parentField != null;

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
    } else if (child.parentField == this) {
      return true;
    } else {
      return isAncestor(child.parentField!);
    }
  }
}
