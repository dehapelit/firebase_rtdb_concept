import 'package:firebase_rtdb_concept/core/init/db/config/main_folder.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/main_folder_config.dart';

extension MainFolderPathExtension on MainFolder {
  String _getPath(MainFolder? folder) => folder?.parentFolder == null
      ? folder?.name ?? ''
      : '${_getPath(folder?.parentFolder)}/${folder?.name}';

  String get path => _getPath(this);
}
