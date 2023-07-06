typedef JsonData = Map<String, dynamic>;

abstract class IJsonModel {
  IJsonModel();
  // ignore: avoid_unused_constructor_parameters
  IJsonModel.fromJson(JsonData data);
  JsonData toJson();
}
