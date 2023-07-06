import 'package:firebase_rtdb_concept/core/init/db/model/base_json_model.dart';

class JsonService {
  JsonService._();
  static JsonData removeNullValues(JsonData data) {
    data.forEach((key, value) {
      if (value == null) {
        data.remove(key);
      }
    });
    return data;
  }
}
