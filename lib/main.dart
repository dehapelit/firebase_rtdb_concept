import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_data_relation_operation.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_list_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_list_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/firebase_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/model/form_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/patient_model.dart';
import 'package:firebase_rtdb_concept/main_utils.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await MainUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: onPressed),
      ),
    );
  }

  Future<void> onPressed() async {
    const id = '-NZkiaMqzOIjhe80X_2W';
    // -------------------------------------------------
    //await _pushPatient();
    //---------------------------------------------------
    //await _formAddOperation(parentId: id);
    // ---------------------------------------------------------
    await _removePatient(id: id);
  }

  Future<void> _removePatient({String? id}) async {
    final relationService = FieldItemDataRelationOperation<Patient>(
      FirebaseListOperationService(),
      FirebaseRelationService(),
      FirebaseRelationService(),
    );
    if (id != null) {
      await relationService.remove(id: id);
    }
  }

  Future<void> _pushPatient() async {
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
    await dataService.pushAll(pList);
  }

  Future<void> _formAddOperation({String? parentId}) async {
    if (parentId != null) {
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
      for (final form in formList) {
        await relationService.push(parentId: parentId, data: form);
      }
    }
  }
}
