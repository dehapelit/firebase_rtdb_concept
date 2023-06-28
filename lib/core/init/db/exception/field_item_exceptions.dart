import 'package:firebase_rtdb_concept/core/init/db/exception/base_exception.dart';

class FieldItemInvalidTypeOnList extends IException {
  const FieldItemInvalidTypeOnList({super.msg});

  @override
  String get name => '$this';
}
