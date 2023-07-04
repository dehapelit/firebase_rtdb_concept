import 'package:firebase_rtdb_concept/core/init/db/extensions/field_item_type_extension.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/data_field_map_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/data_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_list_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';

class FieldItemDataOperation {
  FieldItemDataOperation(this._service);

  final IListOperationService<JsonData> _service;

  FieldItemListDataService<JsonData> _dataService(FieldItem item) =>
      FieldItemListDataService<JsonData>(_service, item);

  Future<DataFieldMap<Data<JsonData>>> get(
    DataFieldMap<String> dataField,
  ) async {
    //set parent data
    final parentJson = await _dataService(dataField.item).get(dataField.data);
    final parentData = Data<JsonData>(data: parentJson, id: dataField.data);
    //set children datas
    final map = <FieldItem, List<Data<JsonData>>>{};
    dataField.dataMap.forEach((item, ids) async {
      final childList = <Data<JsonData>>[];
      for (final id in ids) {
        final childJson = await _dataService(item).get(id);
        childList.add(Data(data: childJson, id: id));
      }
      map[item] = childList;
    });
    //return dataMap
    return DataFieldMap(item: dataField.item, data: parentData, dataMap: map);
  }

  Future<Map<FieldItem, List<Data<JsonData>>>> _getAllHelper(
    String id,
    FieldItem item,
    List<FieldItem> children,
  ) async {
    if (item.hasChildren) {
      for (final child in item.childListFields) {
        if (children.contains(child)) {
          // TO DO: implement recursive field finder algorithm
        }
      }
    }
    return {};
  }
}
