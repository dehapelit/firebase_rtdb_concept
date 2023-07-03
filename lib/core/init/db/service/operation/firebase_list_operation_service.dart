import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/exception/firebase_exceptions.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_operation_service.dart';

typedef FirebaseData = Map<String, dynamic>;

class FirebaseListOperationService
    extends FirebaseOperationService<FirebaseData>
    implements IListOperationService<FirebaseData> {
  factory FirebaseListOperationService() {
    return _instance;
  }

  FirebaseListOperationService._internal();
  static final FirebaseListOperationService _instance =
      FirebaseListOperationService._internal();

  Future<DataSnapshot> getSnapshot(String path) =>
      FirebaseDatabase.instance.ref(path).get();

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
  Future<void> update(String path, FirebaseData data) =>
      FirebaseDatabase.instance.ref(path).update(data);
}
