import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_field_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_id_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class Field implements IdModel, IFieldModel {
  Field({required FieldItem item, String? id})
      : _id = id,
        _item = item;

  final String? _id;
  final FieldItem _item;

  @override
  String? get id => item.isList ? _id : null;

  @override
  FieldItem get item => _item;
}
