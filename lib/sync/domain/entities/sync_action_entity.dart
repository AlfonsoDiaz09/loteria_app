enum SyncType {
  create,
  update,
  delete,
}

class SyncActionEntity {
  final String id;
  final String table; // "cards", "sets"
  final SyncType type; // create | update | delete
  final Map<String, dynamic> data;
  final DateTime createdAt;

  SyncActionEntity({
    required this.id,
    required this.table,
    required this.type,
    required this.data,
    required this.createdAt,
  });
}