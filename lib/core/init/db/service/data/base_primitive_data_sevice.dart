import 'package:firebase_rtdb_concept/core/init/db/service/operation/primitive_operation_service.dart';

abstract class IPrimitiveDataService<T> {
  IPrimitiveDataService(this._service);

  final PrimitiveOperationService<T> _service;

  String get path;

  Future<T> get() => _service.get(path);
  Future<void> set(T data) => _service.set(path, data);
  Future<void> remove() => _service.remove(path);
}
