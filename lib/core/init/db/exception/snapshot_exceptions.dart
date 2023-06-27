import 'package:firebase_rtdb_concept/core/init/db/exception/base_exception.dart';

class SnapshotNotFoundException extends IException {
  SnapshotNotFoundException({super.msg});

  @override
  String get name => '$this';
}

class SnapshotInvalidTypeException extends IException {
  SnapshotInvalidTypeException({super.msg});

  @override
  String get name => '$this';
}
