class SetDto {
  final String id;
  final String name;
  final String description;
  final String? sessionId;
  final bool isDefault;
  final DateTime createdAt;

  SetDto({
    required this.id,
    required this.name,
    required this.description,
    this.sessionId,
    required this.isDefault,
    required this.createdAt,
  });

  factory SetDto.fromJson(Map<String, dynamic> json) {
    return SetDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sessionId: json['session_id'],
      isDefault: json['is_default'] == true || json['is_default'] == 1,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  static List<SetDto> fromList(List data) {
    return data.map((e) => SetDto.fromJson(e)).toList();
  }
}