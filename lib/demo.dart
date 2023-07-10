import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_data_relation_operation.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_list_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_list_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/model/form_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/operation_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/patient_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/treatment_model.dart';

class Demo {
  Demo._();

  static Future<void> add() async {
    final patientIds = await _pushPatient();
    final patientId = patientIds.first;
    final formIds = await _addForm(parentId: patientId);
    for (final formId in formIds) {
      await _addOperationTreatment(id: formId);
    }
  }

  static Future<List<String>> get<T extends IJsonModel>({
    required String parentId,
    required FieldItem parentItem,
  }) async {
    final relationService = FieldItemDataRelationOperation<T>(
      FirebaseListOperationService(),
      FirebaseRelationService(),
      FirebaseRelationService(),
    );
    final result = await relationService.get(
      parentId: parentId,
      parentItem: parentItem,
    );
    return result.map((data) => data.id).whereType<String>().toList();
  }

  static Future<void> remove<T extends IJsonModel>({String? id}) async {
    final relationService = FieldItemDataRelationOperation<T>(
      FirebaseListOperationService(),
      FirebaseRelationService(),
      FirebaseRelationService(),
    );
    if (id != null) {
      await relationService.remove(id: id);
    }
  }

  static Future<List<String>> _pushPatient() {
    final dataService = FieldItemListDataService<Patient>(
      FirebaseListOperationService(),
      FieldItem.patient,
    );
    final p1 = Patient('p1', 1);
    final p2 = Patient('p2', 2);
    final p3 = Patient('p3', 3);
    final p4 = Patient('p4', 4);
    final p5 = Patient('p5', 5);
    final p6 = Patient('p6', 6);
    final pList = [p1, p2, p3, p4, p5, p6];
    return dataService.pushAll(pList);
  }

  static Future<List<String>> _addForm({required String parentId}) {
    final relationService = FieldItemDataRelationOperation<FormModel>(
      FirebaseListOperationService(),
      FirebaseRelationService(),
      FirebaseRelationService(),
    );
    final f1 = FormModel(DateTime(2023, 1, 3), 'detail1');
    final f2 = FormModel(DateTime(2023, 2, 3), 'detail2');
    final f3 = FormModel(DateTime(2023, 3, 3), 'detail3');
    final f4 = FormModel(DateTime(2023, 4, 3), 'detail4');
    final formList = [f1, f2, f3, f4];
    return relationService.pushAll(parentId: parentId, dataList: formList);
  }

  static Future<void> _addOperation({String? id}) async {
    if (id != null) {
      final relationService = FieldItemDataRelationOperation<Operation>(
        FirebaseListOperationService(),
        FirebaseRelationService(),
        FirebaseRelationService(),
      );
      final f1 = Operation(DateTime(2023, 1, 3), 'detail1');
      final f2 = Operation(DateTime(2023, 2, 3), 'detail2');
      final f3 = Operation(DateTime(2023, 3, 3), 'detail3');
      final f4 = Operation(DateTime(2023, 4, 3), 'detail4');
      final list = [f1, f2, f3, f4];
      await relationService.pushAll(parentId: id, dataList: list);
    }
  }

  static Future<void> _addTreatment({String? id}) async {
    if (id != null) {
      final relationService = FieldItemDataRelationOperation<Treatment>(
        FirebaseListOperationService(),
        FirebaseRelationService(),
        FirebaseRelationService(),
      );
      final f1 = Treatment(DateTime(2023, 1, 3), 'detail1');
      final f2 = Treatment(DateTime(2023, 2, 3), 'detail2');
      final f3 = Treatment(DateTime(2023, 3, 3), 'detail3');
      final f4 = Treatment(DateTime(2023, 4, 3), 'detail4');
      final list = [f1, f2, f3, f4];
      await relationService.pushAll(parentId: id, dataList: list);
    }
  }

  static Future<void> _addOperationTreatment({String? id}) async {
    await _addOperation(id: id);
    await _addTreatment(id: id);
  }
}
