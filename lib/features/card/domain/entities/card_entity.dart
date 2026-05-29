class CardEntity {
  final String id;
  final String setId;
  final String name;
  final String imageUrl;
  final int? number;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  CardEntity({
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

  CardEntity copyWith({
    String? id,
    String? setId,
    String? name,
    String? imageUrl,
    int? number,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return CardEntity(
      id: id ?? this.id,
      setId: setId ?? this.setId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      number: number ?? this.number,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}