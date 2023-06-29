import 'package:firebase_rtdb_concept/core/init/db/service/base_relation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_primitive_operation_service.dart';

class FirebaseRelationService extends IRelationService {
  @override
  Future<void> setChild(String path) =>
      FirebasePrimitiveOperationService<bool>().set(path, true);

  @override
  Future<void> setParent(String path, String parentId) =>
      FirebasePrimitiveOperationService<String>().set(path, parentId);

  @override
  Future<void> removeChild(String path) =>
      FirebasePrimitiveOperationService<bool>().remove(path);

  @override
  Future<void> removeParent(String path) =>
      FirebasePrimitiveOperationService<String>().remove(path);

  @override
  Future<String?> getChild(String path) =>
      FirebasePrimitiveOperationService<String?>().get(path);

  @override
  Future<String?> getParent(String path) =>
      FirebasePrimitiveOperationService<String?>().get(path);
}
