import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';

class Treatment extends IJsonModel {
  Treatment();

  factory Treatment.fromJson(JsonData json) => Treatment();

  @override
  JsonData toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
