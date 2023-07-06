import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';
import 'package:firebase_rtdb_concept/core/init/model/service/json_service.dart';

class Patient extends IJsonModel {
  Patient(this.name, this.age);

  @override
  factory Patient.fromJson(JsonData json) => Patient(
        json['name'] as String?,
        (json['age'] as int?)?.toDouble(),
      );

  final String? name;
  final double? age;

  @override
  JsonData toJson() => JsonService.removeNullValues({
        'name': name,
        'age': age,
      });
}
