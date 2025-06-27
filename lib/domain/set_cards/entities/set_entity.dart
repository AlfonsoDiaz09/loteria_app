class SetEntity {
  final String id;
  final String name;
  final String description;
  final String? sesionId;
  final bool isDefault;

  SetEntity({required this.id, required this.name, required this.description, this.sesionId, required this.isDefault});
}