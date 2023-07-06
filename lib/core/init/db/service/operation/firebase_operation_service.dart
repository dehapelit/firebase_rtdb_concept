import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_snapshot_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';

class FirebaseOperationService<T> extends IPrimitiveOperationService<T> {
  FirebaseOperationService();

  @override
  Future<T> get(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return FireBaseSnapshotService.getSnapshotValue(snapshot) as T;
  }

  @override
  Future<void> remove(String path) =>
      FirebaseDatabase.instance.ref(path).remove();

  @override
  Future<void> set(String path, T data) =>
      FirebaseDatabase.instance.ref(path).set(data);
}
