import 'package:firebase_rtdb_concept/core/init/db/service/operation/firebase_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/operation/primitive_operation_service.dart';

class FirebasePrimitiveOperationService<T> extends FirebaseOperationService<T>
    implements PrimitiveOperationService<T> {}
