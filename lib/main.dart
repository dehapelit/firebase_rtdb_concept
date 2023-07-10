import 'package:firebase_rtdb_concept/core/init/db/config/field_item.dart';
import 'package:firebase_rtdb_concept/core/init/model/patient_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/treatment_model.dart';
import 'package:firebase_rtdb_concept/demo.dart';
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
    //Disable unused operation

    /* Add op */
    await Demo.add();
    const id = ''; // set patient id
    /* Remove op */
    await Demo.remove<Patient>(id: id);
    /* Get op */
    final ids =
        await Demo.get<Treatment>(parentId: id, parentItem: FieldItem.form);
    print(ids);
  }
}
