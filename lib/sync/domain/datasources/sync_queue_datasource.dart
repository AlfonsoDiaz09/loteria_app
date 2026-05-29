import 'package:loteria_app/sync/data/models/sync_action_model.dart';

abstract class SyncQueueDatasource {
  Future<void> add(SyncActionModel action);

  Future<List<SyncActionModel>> getAll();

  Future<void> remove(String id);

  Future<void> clear();
}
