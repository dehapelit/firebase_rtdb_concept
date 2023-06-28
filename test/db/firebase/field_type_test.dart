import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Field item type test', () {
    test('Field item shold return correct parent field', () {
      const item = FieldItem.operation;
      expect(item.parentField, FieldItem.form);
    });

    test('Field item shold return empty list if there is no parent', () {
      const item = FieldItem.patient;
      expect(item.parentField, null);
    });

    test('Field item shold return empty list if it is not a list', () {
      const item = FieldItem.theme;
      expect(item.parentField, null);
    });

    test('field items must not have invalid type in childListField', () {
      final list = <List<FieldItem>>[];
      for (final value in FieldItem.values) {
        list.add(value.childListFields);
      }
      expect(list.length, FieldItem.values.length);
    });
  });
}
