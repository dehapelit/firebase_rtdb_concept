import 'package:firebase_rtdb_concept/core/init/db/constants/firebase_folder_names.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/main_folder_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/main_folder.dart';

extension FieldItemPathExtension on FieldItem {
  String get path =>
      parentFolder == null ? name : '${parentFolder!.path}/$name';

  String get name {
    switch (this) {
      case FieldItem.theme:
        return FirebaseFolderNames.fieldItemThemeName;
      case FieldItem.lang:
        return FirebaseFolderNames.fieldItemLangName;
      case FieldItem.patient:
        return FirebaseFolderNames.fieldItemPatientName;
      case FieldItem.form:
        return FirebaseFolderNames.fieldItemFormName;
      case FieldItem.operation:
        return FirebaseFolderNames.fieldItemOperationName;
      case FieldItem.treatment:
        return FirebaseFolderNames.fieldItemTreatmentName;
    }
  }

  MainFolder? get parentFolder {
    switch (this) {
      case FieldItem.theme:
        return MainFolder.settings;
      case FieldItem.lang:
        return MainFolder.settings;
      case FieldItem.patient:
        return MainFolder.items;
      case FieldItem.form:
        return MainFolder.items;
      case FieldItem.operation:
        return MainFolder.items;
      case FieldItem.treatment:
        return MainFolder.items;
    }
  }
}
