import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';

class DataFieldMap<T> {
  DataFieldMap({required this.item, required this.data, required this.dataMap})
      : assert(
          !dataMap.keys.map(item.isAncestor).toList().contains(false),
          'Given item is not ancestor of given dataMap fields',
        );

  final FieldItem item;
  final T data;
  final Map<FieldItem, List<T>> dataMap;
}
