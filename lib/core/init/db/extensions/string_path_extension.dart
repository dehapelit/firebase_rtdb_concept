extension StringPathExtension on String {
  String idPath(String? id) {
    assert(id != null, 'Id path cannot be returned. Given id is null.');
    return '$this/$id';
  }
}
