import 'dart:convert';

import 'package:loteria_app/core/utils/bool_utils.dart';

List<CardModel> cardModelFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));

class CardModel {
  final String id;
  final String setId;
  final String name;
  final String imageUrl;
  final int? number;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;


  CardModel({
    required this.id,
    required this.setId,
    required this.name,
    required this.imageUrl,
    this.number,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      setId: json['set_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      number: json['number'],
      isSynced: BoolUtils().fromJson(json['is_synced']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "set_id": setId,
      "name": name,
      "image_url": imageUrl,
      "number": number,
      "is_synced": isSynced ? 1 : 0,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "deleted_at": deletedAt?.toIso8601String(),
    };
  }
}