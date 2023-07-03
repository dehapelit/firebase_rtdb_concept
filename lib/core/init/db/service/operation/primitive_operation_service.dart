import 'package:firebase_rtdb_concept/core/init/db/service/operation/base_operation_service.dart';
import 'package:firebase_rtdb_concept/core/init/db/structure/firebase_supported_data_types.dart';

abstract class PrimitiveOperationService<T> extends IOperationService<T> {
  PrimitiveOperationService()
      : assert(
          FirebaseSupportedDataTypes.isFirebaseDataType<T>(),
          'Firebase: Unsupported primitive data type',
        );
}
