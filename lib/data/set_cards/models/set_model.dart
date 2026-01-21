import 'dart:convert';

import 'package:loteria_app/core/utils/bool_utils.dart';

List<SetModel> setModelFromJson(String str) => List<SetModel>.from(json.decode(str).map((x) => SetModel.fromJson(x)));

class SetModel {
  final String id;
  final String name;
  final String description;
  final String? sesionId;
  final bool isDefault;

  SetModel({
    required this.id,
    required this.name,
    required this.description,
    this.sesionId,
    required this.isDefault,
  });

  factory SetModel.fromJson(Map<String, dynamic> json) => 
    SetModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sesionId: json['sesion_id'],
      isDefault: BoolUtils().fromJson(json['is_default']));

  Map<String,dynamic> toJson() => {
    "id":id,
    "name": name,
    "description": description,
    "sesion_id": sesionId,
    "is_default": isDefault ? 1 : 0};
}