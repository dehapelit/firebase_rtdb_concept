import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';

class Patient extends IJsonModel {
  Patient();

  factory Patient.fromJson(JsonData json) => Patient();

  @override
  JsonData toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
