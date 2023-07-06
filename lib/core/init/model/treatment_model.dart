import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/service/json_service.dart';

class Treatment extends IJsonModel {
  Treatment(this.date, this.note);

  factory Treatment.fromJson(JsonData json) => Treatment(
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
