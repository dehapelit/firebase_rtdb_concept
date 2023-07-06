import 'package:firebase_rtdb_concept/core/init/db/service/data/field_item_list_data_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_list_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/field_item.dart';
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
    final service = FieldItemListDataService<Patient>(
      FirebaseListOperationService(),
      FieldItem.patient,
    );
    final patient1 = Patient('name12', 111);
    final id = '-NZg2GoQ3eaAhmUcQ3TV';
    final patients = await service.pushAll(
      [patient1, patient1, patient1],
    );
  }
}
