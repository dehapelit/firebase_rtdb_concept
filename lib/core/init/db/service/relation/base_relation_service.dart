abstract class IRelationService<T> {
  Future<void> set(String path, T value);
  Future<void> remove(String path);
  Future<String?> get(String path);
  Future<List<String>> getAll(String path);
}
