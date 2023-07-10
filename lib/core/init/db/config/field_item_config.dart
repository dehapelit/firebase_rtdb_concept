// ignore_for_file: unreachable_switch_case

import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/main_folder.dart';
import 'package:firebase_rtdb_concept/core/init/db/constants/firebase_folder_names.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/form_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/operation_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/patient_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/treatment_model.dart';

extension FieldItemConfig on FieldItem {
  /// returns key value of the field on firebase rtdb.
  String get name {
    return switch (this) {
      FieldItem.theme => FirebaseFolderNames.fieldItemThemeName,
      FieldItem.lang => FirebaseFolderNames.fieldItemLangName,
      FieldItem.patient => FirebaseFolderNames.fieldItemPatientName,
      FieldItem.form => FirebaseFolderNames.fieldItemFormName,
      FieldItem.operation => FirebaseFolderNames.fieldItemOperationName,
      FieldItem.treatment => FirebaseFolderNames.fieldItemTreatmentName,
      _ => throw UnimplementedError()
    };
  }

  /// returns parent folder of the field.
  /// returns null if there is no parent folder.
  MainFolder? get parentFolder {
    return switch (this) {
      FieldItem.theme => MainFolder.settings,
      FieldItem.lang => MainFolder.settings,
      FieldItem.patient => MainFolder.items,
      FieldItem.form => MainFolder.items,
      FieldItem.operation => MainFolder.items,
      FieldItem.treatment => MainFolder.items,
      _ => null
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

  /// returns true if field is a list in firebase rtdb.
  bool get isList {
    return switch (this) {
      FieldItem.patient => true,
      FieldItem.form => true,
      FieldItem.operation => true,
      FieldItem.treatment => true,
      _ => false
    };
  }

  /// returns fromJson constructor of IJsonModel objects.
  T fromJson<T extends IJsonModel>(JsonData json) {
    return switch (this) {
      FieldItem.patient => Patient.fromJson(json) as T,
      FieldItem.form => FormModel.fromJson(json) as T,
      FieldItem.operation => Operation.fromJson(json) as T,
      FieldItem.treatment => Treatment.fromJson(json) as T,
      _ => throw UnimplementedError()
    };
  }

  /// returns true if the generic type is valid.
  bool isValidType<T>() {
    return switch (this) {
      FieldItem.lang => String == T,
      FieldItem.theme => String == T,
      FieldItem.patient => Patient == T,
      FieldItem.form => FormModel == T,
      FieldItem.operation => Operation == T,
      FieldItem.treatment => Treatment == T,
      _ => false
    };
  }
}
