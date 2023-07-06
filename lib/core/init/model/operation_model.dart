import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/service/json_service.dart';

class Operation extends IJsonModel {
  Operation(this.date, this.note);

  factory Operation.fromJson(JsonData json) => Operation(
        DateTime.tryParse(json['date'] as String? ?? ''),
        json['note'] as String?,
      );

  final DateTime? date;
  final String? note;

  @override
  JsonData toJson() => JsonService.removeNullValues({
        'date': date?.toString(),
        'note': note,
      });
}
