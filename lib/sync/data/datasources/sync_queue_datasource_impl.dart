import 'dart:convert';

import 'package:loteria_app/core/database/db_isolate.dart';
import 'package:loteria_app/sync/data/models/sync_action_model.dart';
import 'package:loteria_app/sync/domain/datasources/sync_queue_datasource.dart';
import 'package:loteria_app/sync/domain/entities/sync_action_entity.dart';

class SyncQueueDatasourceImpl implements SyncQueueDatasource {

  @override
  Future<void> add(SyncActionModel action) async {
    final db = await DbIsolate.localDatabase;

    await db.insert('sync_queue', {
      'id': action.id,
      'table_name': action.table,
      'type': action.type.name,
      'data': jsonEncode(action.data),
      'created_at': action.createdAt.toIso8601String(),
    });
  }

  @override
  Future<List<SyncActionModel>> getAll() async {
    final db = await DbIsolate.localDatabase;

    final result = await db.query('sync_queue');

    final list = result.map((e) {
      return SyncActionModel(
        id: e['id'] as String,
        table: e['table_name'] as String,
        type: SyncType.values.firstWhere(
              (t) => t.name == e['type'],
        ),
        data: jsonDecode(e['data'] as String),
        createdAt: DateTime.parse(e['created_at'] as String),
      );
    }).toList();

    list.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return list;
  }

  @override
  Future<void> remove(String id) async {
    final db = await DbIsolate.localDatabase;

    await db.delete(
      'sync_queue',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> clear() async {
    final db = await DbIsolate.localDatabase;

    await db.delete('sync_queue');
  }
}