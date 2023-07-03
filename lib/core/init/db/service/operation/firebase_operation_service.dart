import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_snapshot_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';

class FirebaseOperationService<T> extends IOperationService<T> {
  FirebaseOperationService();

  @override
  Future<List<T>> getAll(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return snapshot.children
        .map(
          (child) => FireBaseSnapshotService.getSnapshotValue<T>(child),
        )
        .toList();
  }

  @override
  Future<T> get(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return FireBaseSnapshotService.getSnapshotValue<T>(snapshot);
  }

  @override
  Future<void> remove(String path) =>
      FirebaseDatabase.instance.ref(path).remove();

  @override
  Future<void> set(String path, T data) =>
      FirebaseDatabase.instance.ref(path).set(data);

  @override
  Future<List<String>> getAllKeys(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return snapshot.children
        .map((child) => child.key)
        .whereType<String>()
        .toList();
  }
}
