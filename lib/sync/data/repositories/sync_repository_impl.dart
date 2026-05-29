import 'package:loteria_app/core/id_generator/id_generator.dart';
import 'package:loteria_app/features/card/domain/datasources/card_remote_datasource.dart';
import 'package:loteria_app/features/set/domain/datasources/set_remote_datasource.dart';
import 'package:loteria_app/sync/data/models/sync_action_model.dart';
import 'package:loteria_app/sync/domain/datasources/sync_queue_datasource.dart';
import 'package:loteria_app/sync/domain/entities/sync_action_entity.dart';
import 'package:loteria_app/sync/domain/repositories/sync_repository.dart';

class SyncRepositoryImpl implements SyncRepository {
  final SyncQueueDatasource localSync;
  // final CardRemoteDatasource remoteCard;
  // final SetRemoteDatasource remoteSet;
  final IdGenerator idGenerator;


  SyncRepositoryImpl({
    required this.localSync,
    // required this.remoteCard,
    // required this.remoteSet,
    required this.idGenerator,
  });

  @override
  Future<void> addAction(SyncActionEntity action) async {
    final model = SyncActionModel(
      id: idGenerator.generate(),
      table: action.table,
      type: action.type,
      data: action.data,
      createdAt: DateTime.now(),
    );

    await localSync.add(model);
  }

  @override
  Future<List<SyncActionEntity>> getPendingActions() async {
    return await localSync.getAll();
  }

  @override
  Future<void> removeAction(String id) async {
    await localSync.remove(id);
  }

  ///  CORE DEL SYNC
  @override
  Future<void> processAction(SyncActionEntity action) async {
    switch (action.table) {
      case 'cards':
        await _processCard(action);
        break;

      case 'sets':
        await _processSet(action);
        break;
    }
  }

  Future<void> _processCard(SyncActionEntity action) async {
    switch (action.type) {
      case SyncType.create:
        // await remoteCard.createCard(action.data);
        break;

      case SyncType.update:
        // await remoteCard.updateCard(action.data);
        break;

      case SyncType.delete:
        // await remoteCard.deleteCard(action.data['id']);
        break;
    }
  }

  Future<void> _processSet(SyncActionEntity action) async {
    switch (action.type) {
      case SyncType.create:
        // await remoteSet.createSet(action.data);
        break;

      case SyncType.update:
        // await remoteSet.updateSet(action.data);
        break;

      case SyncType.delete:
        // await remoteSet.deleteSet(action.data['id']);
        break;
    }
  }
}