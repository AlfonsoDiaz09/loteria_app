import 'package:loteria_app/sync/domain/entities/sync_action_entity.dart';

class SyncActionModel extends SyncActionEntity {
  SyncActionModel({
    required super.id,
    required super.table,
    required super.type,
    required super.data,
    required super.createdAt,
  });

  factory SyncActionModel.fromJson(Map<String, dynamic> json) {
    return SyncActionModel(
      id: json['id'],
      table: json['table'],
      type: SyncType.values.firstWhere(
            (e) => e.name == json['type'],
      ),
      data: Map<String, dynamic>.from(json['data']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'table': table,
      'type': type.name,
      'data': data,
      'created_at': createdAt.toIso8601String(),
    };
  }
}