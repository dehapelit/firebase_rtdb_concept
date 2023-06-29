abstract class IOperationService<T> {
  Future<T> get(String path);
  Future<void> set(String path, T data);
  Future<void> remove(String path);
}

abstract class IListOperationService<T> extends IOperationService<T> {
  Future<void> update(String path, T data);
  Future<String> push(String path, T data);
}
