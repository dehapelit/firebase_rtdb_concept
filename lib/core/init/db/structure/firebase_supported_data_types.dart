// ignore_for_file: unrelated_type_equality_checks

enum FirebaseSupportedDataTypes {
  string,
  boolean,
  double;

  static bool isFirebaseDataType<T>() => FirebaseSupportedDataTypes.values
      .map((value) => value.isValidType<T>())
      .toList()
      .contains(true);
}

extension TypeExtension on FirebaseSupportedDataTypes {
  bool isValidType<T>() {
    switch (this) {
      case FirebaseSupportedDataTypes.string:
        return T == String;
      case FirebaseSupportedDataTypes.boolean:
        return T == bool;
      case FirebaseSupportedDataTypes.double:
        return T == double;
    }
  }
}
