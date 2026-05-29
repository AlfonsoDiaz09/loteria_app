import 'package:loteria_app/sync/domain/entities/sync_action_entity.dart';

abstract class SyncRepository {
  Future<void> addAction(SyncActionEntity action);

  Future<List<SyncActionEntity>> getPendingActions();

  Future<void> removeAction(String id);

  Future<void> processAction(SyncActionEntity action);
}