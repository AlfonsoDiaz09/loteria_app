class SetEntity {
  final String id;
  final String name;
  final String description;
  final String? sessionId;
  final bool isDefault;

  SetEntity({
    required this.id,
    required this.name,
    required this.description,
    this.sessionId,
    required this.isDefault,
  });
}