import 'dart:convert';

import 'package:loteria_app/domain/set_cards/entities/set_entity.dart';

List<SetModel> setModelFromJson(String str) => List<SetModel>.from(json.decode(str).map((x) => SetModel.fromJson(x)));

class SetModel extends SetEntity {
  SetModel({
    required super.id,
    required super.name,
    required super.description,
    String? sesionId,
    required super.isDefault,
  });

  factory SetModel.fromJson(Map<String, dynamic> json) => 
    SetModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sesionId: json['sesion_id'],
      isDefault: json['is_default']);

  Map<String,dynamic> toJson() => {
    "id":id,
    "name": name,
    "description": description,
    "sesionId": sesionId,
    "isDefault": isDefault};
}