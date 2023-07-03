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

  // returns fromJson constructor for IJsonModel objects.
  T fromJson<T extends IJsonModel>(JsonData json) {
    switch (this) {
      case FieldItem.patient:
        return Patient.fromJson(json) as T;
      case FieldItem.form:
        return Form.fromJson(json) as T;
      case FieldItem.operation:
        return Operation.fromJson(json) as T;
      case FieldItem.treatment:
        return Treatment.fromJson(json) as T;
      // ignore: no_default_cases
      default:
        throw UnimplementedError();
    }
  }

  /// returns true if type is correct.
  bool isValidType<T>() {
    switch (this) {
      case FieldItem.theme:
        return T == String;
      case FieldItem.lang:
        return T == String;
      case FieldItem.patient:
        return T == Patient;
      case FieldItem.form:
        return T == Form;
      case FieldItem.operation:
        return T == Operation;
      case FieldItem.treatment:
        return T == Treatment;
    }
  }

  /// returns true if the field holds lists in the model.
  bool get hasChildren => childListFields.isNotEmpty;

  /// returns true if the current field has a parent field.
  bool get hasParent => parentField != null;

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
