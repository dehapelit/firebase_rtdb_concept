import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/field_item_config.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/main_folder_path_extension.dart';

extension FieldItemPathExtension on FieldItem {
  String get path => folder == null ? name : '${folder!.path}/$name';
}
