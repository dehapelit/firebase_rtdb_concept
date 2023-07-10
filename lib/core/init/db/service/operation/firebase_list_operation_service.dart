import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/exception/firebase_exceptions.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/data_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_snapshot_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_operation_service.dart';

class FirebaseListOperationService extends FirebaseOperationService<JsonData>
    implements IListOperationService<JsonData> {
  factory FirebaseListOperationService() {
    return _instance;
  }

  FirebaseListOperationService._internal();
  static final FirebaseListOperationService _instance =
      FirebaseListOperationService._internal();

  Future<DataSnapshot> getSnapshot(String path) =>
      FirebaseDatabase.instance.ref(path).get();

  @override
  Future<JsonData> get(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return Map.from(
      FireBaseSnapshotService.getSnapshotValue(snapshot) as Map,
    );
  }

  @override
  Future<List<Data<JsonData>>> getAll(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return snapshot.children
        .map(
          (child) => Data<JsonData>(
            id: child.key,
            data: Map.from(
              FireBaseSnapshotService.getSnapshotValue(child) as Map,
            ),
          ),
        )
        .toList();
  }

  @override
  Future<List<String>> getAllKeys(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return snapshot.children
        .map((child) => child.key)
        .whereType<String>()
        .toList();
  }

  @override
  Future<String> push(String path, JsonData data) async {
    final pushRef = FirebaseDatabase.instance.ref(path).push();
    await pushRef.set(data);
    if (pushRef.key == null) {
      throw FirebasePushOperationFailed();
    }
    return pushRef.key!;
  }

  @override
  Future<void> update(String path, JsonData data) => FirebaseDatabase.instance
      .ref(path)
      .update(Map<String, dynamic>.from(data));
}
