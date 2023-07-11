# Firebase Realtime Database Concept

## Getting Started
A Flutter project that provides Firebase Realtime Database services for handling db operations.

## Features
- Configuration of the database with enums and extensions
- Folder structure management
- Separate type handling (primitive, list)
- Basic db operations (set, get, push, remove, update)
- Auto-generated parent-child relations
- Collective list operations (get, push, remove)

## Setup

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/dehapelit/firebase_rtdb_concept.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Configurate your Firebase Realtime Database to the project:

- [Get Started with Realtime Database](https://firebase.google.com/docs/database/flutter/start)


## Creating a Folder
If you want to create a folder, add your folder item to `MainFolder`. Then, you need to make some configuration on `MainFolderConfig`.

### Main Folder Configurations

| Name        | Description           |
| ------------- |:-------------:|
| name    | Set your folder name.|
| folder      | Set the parent folder if exists.    |

## Creating a Model
All of your models must extend the `IJsonModel`. You need to implement `.fromJson` constructor and `toJson` method.

```dart
class Patient extends IJsonModel {
  Patient(this.name, this.age);

  @override
  factory Patient.fromJson(JsonData json) => Patient(
        json['name'] as String?,
        (json['age'] as num?)?.toDouble(),
      );

  final String? name;
  final double? age;

  @override
  JsonData toJson() => JsonService.removeNullValues({
        'name': name,
        'age': age,
      });
}
```

## Creating a Field
If you want to add data to the db, first you need to define a field on `FieldItem`. And then you need to configure your field on `FieldItemConfig`.

### Field Item Configurations

| Name        | Description           |
| ------------- |:-------------:|
| name    | Set your field name.|
| folder      | Set a `MainFolder` for your field.     |
| isList | If your field is stored as a list, set this `true`.      |
| parentField | If there is a `FieldItem` that contains your field as a list, set this `FieldItem` as a parent.      |
| fromJson<T> | If your field is a list, then you need to set fromJson method for your field.      |
| isValidType<T> | Set a condition for generic type and model equality.     |


## Operations
### Primitive Operations
Firebase Realtime Database supports 3 main types which are String, bool and num. All these types are predefined on this application. 

If you define a primitive field and you want to make a db call then you can use `FieldItemPrimitiveDataService<T>` as a service class. Supported operations are:

```dart
Future<T> get();
Future<void> set(T data);
Future<void> remove();
```

***Be careful!*** Generic type must be one of the primitive types that mantioned above. Otherwise exception will be thrown.

### List Operations
You can also have a list as a field type. If you define a list field and want to call a list operation then you can use `FieldItemListDataService<T>` as a service class. Since the service class is a generic type, you must provide `IJsonModel` as a generic type parameter. Supported operations are:

```dart
  Future<List<Data<T>>> getAll();
  Future<T?> get(String id);
  Future<String> push(T data);
  Future<void> remove(String id);
  Future<void> update(String id, T data);
```

### Relation Operations
In Firebase RTDB, When it comes to managing data lists, there must be a consideration for how the relations between parent and child will be handled. The approach being followed on this project is creating a new folder `relations` that holds child and parent relation information. This folder will be automatically generated if `FieldItemDataRelationOperation<T>` service is used.

`FieldItemDataRelationOperation<T>` service has three main operations:
```dart
 // Gets an ancestor id and returns all the descendant children.
  Future<List<Data<T>>>({required String, required FieldItem}) ;
  // Gets a parent id, pushes the item and set relations between parent and child.
  Future<String> push({required String, required T data});
  // Removes item and its all descendant children.
  Future<void> remove({required String id}); 
```