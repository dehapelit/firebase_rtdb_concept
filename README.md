# firebase_rtdb_concept

## Getting Started
A Flutter project that provides Firebase Realtime Database services for handling db operations.

## Features
- Configuration of the database with enums and extensions
- Folder structure management
- Separate type handling (primitive, list)
- Basic db operations (set, get, push, remove, update)
- Auto generated parent-child relations
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

## Configuration

### Creating a Folder
If you want to create a folder, add your folder item to `MainFolder`. Then, you need to make some configuration on `MainFolderConfig`.
**name:** Set your folder name.
**parentFolder:** Set the parent folder if exists.

### Creating a Model
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

### Creating a Field
If you want to add a data to your db, first you need to define a field on `FieldItem`. And then you need to configure your field on `FieldItemConfig`.

**name:** Set your field name.
**folder:** Set a `MainFolder` for your field.
**isList:** If your field is stored as a list, set this `true`.
**parentField:** If there is a `FieldItem` that contains your field as a list, set this `FieldItem` as a parent.
**fromJson<T>:** If your field is a list, then you need to set fromJson method for your field.
**isValidType<T>:** Set a condition for generic type and model equality.

## Usage
### Data Operations
#### Primitive Operations
Firebase Realtime Database supports 3 main types which are String, bool and num. All this types are predefined on this application. 

If you define a primitive field and you want to make a db calls then you can use `FieldItemPrimitiveDataService<T>` as a service class. Supported operations are:

'''
get
set
remove
'''

***Be careful!*** Generic type must be one of the primitive tpyes mantioned above. Otherwise exception will be thrown.

#### List Operations
You can also have list as a field type. If you define a list field and want to make a list operations then you can use `FieldItemListDataService<T>` as a service class. Since the service class is a generic type, you must provide `IJsonModel` as a generic type paramater.  Supported operations are:

'''
get
getAll 
push
pushAll
remove 
removeAll
update
updateAll
'''

### Relation Operations
When it comes to manage lists in databases, there must be a consideration for how the relation between parent and child will be handled. The approach being followed on this project is creating a new folder named relations and holding child and parent information on this folder. This folder will be automatically generated if `FieldItemDataRelationOperation<T>` service is used.

`FieldItemDataRelationOperation<T>` service has three main operations:
**get:** Gets an ancestor id and returns all the descendant children.
**push:** Gets a parent id, pushes the item and set relation between parent and child.
**remove:** Gets a id, remove item and its all descendant children.