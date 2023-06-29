import 'package:firebase_rtdb_concept/core/init/db/exception/base_exception.dart';

class FirebaseUnSupportedDataTypeExtension extends IException {
  FirebaseUnSupportedDataTypeExtension({super.msg});

  @override
  String get name => '$this';
}

class FirebasePushOperationFailed extends IException {
  FirebasePushOperationFailed({super.msg});

  @override
  String get name => '$this';
}
