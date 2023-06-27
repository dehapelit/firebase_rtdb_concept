import 'package:firebase_rtdb_concept/core/init/db/constants/firebase_folder_names.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/main_folder.dart';

enum ListFolder {
  patient,
  form,
  operation,
  treatment;
}

extension ListFolderPathExtension on ListFolder {
  String get path =>
      parentFolder == null ? name : '${parentFolder!.path}/$name';

  String get name {
    switch (this) {
      case ListFolder.patient:
        return FirebaseFolderNames.listFolderPatientName;
      case ListFolder.form:
        return FirebaseFolderNames.listFolderFormName;
      case ListFolder.operation:
        return FirebaseFolderNames.listFolderOperationName;
      case ListFolder.treatment:
        return FirebaseFolderNames.listFolderTreatmentName;
    }
  }

  MainFolder? get parentFolder {
    switch (this) {
      case ListFolder.patient:
        return MainFolder.items;
      case ListFolder.form:
        return MainFolder.items;
      case ListFolder.operation:
        return MainFolder.items;
      case ListFolder.treatment:
        return MainFolder.items;
    }
  }
}
