extension StringPathExtension on String {
  String idPath(String? id) => id == null ? this : '$this/$id';
}
