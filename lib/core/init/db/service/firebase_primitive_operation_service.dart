import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_snapshot_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/firebase_supported_data_types.dart';

class FirebasePrimitiveOperationService<T> extends IOperationService<T> {
  FirebasePrimitiveOperationService()
      : assert(
          FirebaseSupportedDataTypes.isFirebaseDataType<T>(),
          'Firebase: Unsupported primitive data type',
        );

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
}
