import 'package:firebase_rtdb_concept/core/init/db/model/data_model.dart';

abstract class IPrimitiveOperationService<T> {
  Future<T> get(String path);
  Future<void> set(String path, T data);
  Future<void> remove(String path);
}

abstract class IListOperationService<T> extends IPrimitiveOperationService<T> {
  Future<List<Data<T>>> getAll(String path);
  Future<List<String>> getAllKeys(String path);
  Future<void> update(String path, T data);
  Future<String> push(String path, T data);
}
