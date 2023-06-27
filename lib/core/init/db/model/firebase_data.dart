import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_id_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/db/service/firebase_snapshot_service.dart';

class FireBaseData<T extends IJsonModel> extends IdModel {
  const FireBaseData({super.id, this.data});
  factory FireBaseData.fromSnapshot(
    DataSnapshot snapshot, {
    required T Function(Map<String, dynamic>) fromJson,
  }) =>
      FireBaseData(
        id: snapshot.key,
        data: fromJson(
          FireBaseSnapshotService.getSnapshotValue<Map<String, dynamic>>(
            snapshot,
          ),
        ),
      );

  final T? data;
}
