import 'package:firebase_rtdb_concept/core/init/db/model/base_id_model.dart';

class Data<T> extends IdModel {
  Data({this.data, super.id});
  final T? data;
}
