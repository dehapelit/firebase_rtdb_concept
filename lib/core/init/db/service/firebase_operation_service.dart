import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/exception/firebase_exceptions.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_snapshot_service.dart';

typedef FirebaseData = Map<String, dynamic>;

class FirebaseOperationService extends IListOperationService<FirebaseData> {
  factory FirebaseOperationService() {
    return _instance;
  }

  FirebaseOperationService._internal();
  static final FirebaseOperationService _instance =
      FirebaseOperationService._internal();

  Future<DataSnapshot> getSnapshot(String path) =>
      FirebaseDatabase.instance.ref(path).get();

  @override
  Future<FirebaseData> get(String path) async {
    final snapshot = await FirebaseDatabase.instance.ref(path).get();
    return FireBaseSnapshotService.getSnapshotValue<FirebaseData>(snapshot);
  }

  @override
  Future<String> push(String path, FirebaseData data) async {
    final pushRef = FirebaseDatabase.instance.ref(path).push();
    await pushRef.set(data);
    if (pushRef.key == null) {
      throw FirebasePushOperationFailed();
    }
    return pushRef.key!;
  }

  @override
  Future<void> remove(String path) =>
      FirebaseDatabase.instance.ref(path).remove();

  @override
  Future<void> set(String path, FirebaseData data) =>
      FirebaseDatabase.instance.ref(path).set(data);

  @override
  Future<void> update(String path, FirebaseData data) =>
      FirebaseDatabase.instance.ref(path).update(data);
}
