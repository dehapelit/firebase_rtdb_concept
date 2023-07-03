import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_primitive_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/relation/base_relation_service.dart';

class FirebaseRelationService<T> extends IRelationService<T> {
  @override
  Future<void> set(String path, T value) =>
      FirebasePrimitiveOperationService<T>().set(path, value);

  @override
  Future<void> remove(String path) =>
      // ignore: inference_failure_on_instance_creation
      FirebasePrimitiveOperationService().remove(path);

  @override
  Future<String?> get(String path) =>
      FirebasePrimitiveOperationService<String>().get(path);

  @override
  Future<List<String>> getAll(String path) =>
      FirebasePrimitiveOperationService<T>().getAllKeys(path);
}
