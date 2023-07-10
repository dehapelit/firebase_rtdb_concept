import 'package:firebase_rtdb_concept/core/init/db/structure/firebase_supported_data_types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Firebase operation test', () {
    test('Firebase primitive type test', () {
      expect(FirebaseSupportedDataTypes.isFirebaseDataType<bool>(), true);
      expect(FirebaseSupportedDataTypes.isFirebaseDataType<num>(), true);
      expect(FirebaseSupportedDataTypes.isFirebaseDataType<String>(), true);
      expect(FirebaseSupportedDataTypes.isFirebaseDataType<DateTime>(), false);
    });
  });
}
