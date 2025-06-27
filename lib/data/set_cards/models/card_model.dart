import 'dart:convert';

List<CardModel> cardModelFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));

class CardModel {
  final String id;
  final String setId;
  final String name;
  final String imageUrl;
  final int? number;

  CardModel({
    required this.id,
    required this.setId,
    required this.name,
    required this.imageUrl,
    this.number,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => 
    CardModel(
      id: json['id'],
      setId: json['set_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      number: json['number']);

  Map<String,dynamic> toJson() => {
    "id":id,
    "set_id": setId,
    "name": name,
    "image_url": imageUrl,
    "number": number};
}