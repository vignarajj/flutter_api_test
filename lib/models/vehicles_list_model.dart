import 'dart:convert';

VehicleListModel vehicleListModelFromJson(String str) => VehicleListModel.fromJson(json.decode(str));

String vehicleListModelToJson(VehicleListModel data) => json.encode(data.toJson());

class VehicleListModel {
  VehicleListModel({
    required this.vehicleList,
  });

  List<VehicleModel> vehicleList;

  factory VehicleListModel.fromJson(Map<String, dynamic> json) => VehicleListModel(
    vehicleList: List<VehicleModel>.from(json["vehicleList"].map((x) => VehicleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vehicleList": List<dynamic>.from(vehicleList.map((x) => x.toJson())),
  };
}

class VehicleModel {
  VehicleModel({
    required this.id,
    required this.name,
    required this.model,
    required this.age,
    required this.image,
    required this.description,
  });

  int id;
  String name;
  String model;
  int age;
  String image;
  String description;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    id: json["id"],
    name: json["name"],
    model: json["model"],
    age: json["age"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "model": model,
    "age": age,
    "image": image,
    "description": description,
  };
}
