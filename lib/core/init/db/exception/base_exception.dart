abstract class IException implements Exception {
  const IException({this.msg});

  final String? msg;
  String get name;

  @override
  String toString() => '$name: $msg';
}
