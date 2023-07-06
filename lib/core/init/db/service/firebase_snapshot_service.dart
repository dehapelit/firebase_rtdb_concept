import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/exception/snapshot_exceptions.dart';

class FireBaseSnapshotService {
  FireBaseSnapshotService._();

  static dynamic getSnapshotValue(DataSnapshot snapshot) {
    if (!snapshot.exists) {
      throw SnapshotNotFoundException();
    } else if (snapshot.value == null) {
      throw SnapshotInvalidTypeException();
    } else {
      return snapshot.value;
    }
  }
}
