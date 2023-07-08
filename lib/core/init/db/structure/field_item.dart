import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';

enum FieldItem {
  theme,
  lang,
  patient,
  form,
  operation,
  treatment;

  //get item from the generic type
  static FieldItem? getItemFromType<T>() {
    for (final value in FieldItem.values) {
      if (value.isValidType<T>()) {
        return value;
      }
    }
    return null;
  }
}
