import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/service/json_service.dart';

class FormModel extends IJsonModel {
  FormModel(this.date, this.detail);

  factory FormModel.fromJson(JsonData json) => FormModel(
        DateTime.tryParse(json['date'] as String? ?? ''),
        json['detail'] as String?,
      );

  final DateTime? date;
  final String? detail;

  @override
  JsonData toJson() => JsonService.removeNullValues({
        'date': date?.toString(),
        'detail': detail,
      });
}
