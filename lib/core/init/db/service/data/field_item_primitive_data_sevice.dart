import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_path_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/base_primitive_data_sevice.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class FieldItemPrimitiveDataService<T> extends IPrimitiveDataService<T> {
  FieldItemPrimitiveDataService(super.service, this.item)
      : assert(!item.isList, 'Given item cannot be a list type');

  final FieldItem item;

  @override
  String get path => item.path;
}
