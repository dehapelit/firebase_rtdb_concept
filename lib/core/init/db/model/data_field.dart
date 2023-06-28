import 'package:firebase_rtdb_concept/core/init/db/model/field_model.dart';

class DataField<T> extends Field {
  DataField({required super.item, super.id, this.data});

  final T? data;
}
