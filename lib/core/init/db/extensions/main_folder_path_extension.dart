import 'package:firebase_rtdb_concept/core/init/db/config/main_folder.dart';
import 'package:firebase_rtdb_concept/core/init/db/constants/firebase_folder_names.dart';

extension MainFolderPathExtension on MainFolder {
  String _getPath(MainFolder? folder) => folder?.parentFolder == null
      ? folder?.name ?? ''
      : '${_getPath(folder?.parentFolder)}/${folder?.name}';

  String get path => _getPath(this);

  String get name {
    switch (this) {
      case MainFolder.root:
        return FirebaseFolderNames.mainFolderRootName;
      case MainFolder.items:
        return FirebaseFolderNames.mainFolderItemsName;
      case MainFolder.settings:
        return FirebaseFolderNames.mainFolderSettingsName;
    }
  }

  MainFolder? get parentFolder {
    switch (this) {
      case MainFolder.root:
        return null;
      case MainFolder.items:
        return MainFolder.root;
      case MainFolder.settings:
        return MainFolder.root;
    }
  }
}
