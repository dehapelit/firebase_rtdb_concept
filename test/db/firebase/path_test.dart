import 'package:firebase_rtdb_concept/core/init/db/config/main_folder.dart';
import 'package:firebase_rtdb_concept/core/init/db/config/main_folder_config.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/main_folder_path_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MainFolder should return the correct path', () {
    const folder = MainFolder.settings;
    expect(folder.path, '${folder.parentFolder?.name}/${folder.name}');
  });
}
