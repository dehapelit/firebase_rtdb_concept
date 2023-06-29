import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/field_model.dart';

class DataField<T extends IJsonModel> extends Field {
  DataField({required super.item, super.id, super.parentId, this.data});

  final T? data;
}
