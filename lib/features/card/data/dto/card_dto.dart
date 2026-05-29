class CardDto {
  final String id;
  final String setId;
  final String name;
  final String imageUrl;
  final int? number;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  CardDto({
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

  factory CardDto.fromJson(Map<String, dynamic> json) {
    return CardDto(
      id: json['id'],
      setId: json['set_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      number: json['number'],
      isSynced: json['is_synced'] == true || json['is_synced'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'set_id': setId,
      'name': name,
      'image_url': imageUrl,
      'number': number,
      'is_synced': isSynced ? true : false,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  static List<CardDto> fromList(List data) {
    return data.map((e) => CardDto.fromJson(e)).toList();
  }
}