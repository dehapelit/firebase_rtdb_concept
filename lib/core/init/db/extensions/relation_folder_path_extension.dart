import 'package:firebase_rtdb_concept/core/init/db/constants/firebase_folder_names.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/string_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/relation_folder.dart';

extension RelationFolderPathExtension on RelationFolder {
  String get _path =>
      this == RelationFolder.root ? name : '${RelationFolder.root.name}/$name';

  String getPath({required FieldItem item, required String id}) =>
      '$_path/${item.name}'.idPath(id);

  String get name {
    switch (this) {
      case RelationFolder.root:
        return FirebaseFolderNames.relationFolderName;
      case RelationFolder.parent:
        return FirebaseFolderNames.relationParentFolderName;
      case RelationFolder.children:
        return FirebaseFolderNames.relationChildrenFolderName;
    }
  }
}
