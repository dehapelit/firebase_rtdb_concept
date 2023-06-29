abstract class IRelationService {
  Future<void> setParent(String path, String parentId);
  Future<void> setChild(String path);
  Future<void> removeParent(String path);
  Future<void> removeChild(String path);
  Future<String?> getChild(String path);
  Future<String?> getParent(String path);
}
