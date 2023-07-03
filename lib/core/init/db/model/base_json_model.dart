typedef JsonData = Map<String, dynamic>;

abstract class IJsonModel {
  IJsonModel();
  JsonData toJson();
}
