// ignore_for_file: unreachable_switch_case

import 'package:firebase_rtdb_concept/core/init/db/constants/firebase_folder_names.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/main_folder.dart';

extension MainFolderConfig on MainFolder {
  String get name {
    return switch (this) {
      MainFolder.root => FirebaseFolderNames.mainFolderRootName,
      MainFolder.items => FirebaseFolderNames.mainFolderItemsName,
      MainFolder.settings => FirebaseFolderNames.mainFolderSettingsName,
      _ => throw UnimplementedError()
    };
  }

  MainFolder? get parentFolder {
    return switch (this) {
      MainFolder.root => null,
      MainFolder.items => MainFolder.root,
      MainFolder.settings => MainFolder.root,
      _ => throw UnimplementedError()
    };
  }
}
