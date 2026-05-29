import 'package:loteria_app/sync/domain/repositories/sync_repository.dart';

class SyncAll {
  final SyncRepository repository;

  SyncAll({required this.repository});

  Future<void> call() async {
    final actions = await repository.getPendingActions();

    for (final action in actions) {
      try {
        await repository.processAction(action);
        await repository.removeAction(action.id);
      } catch (_) {
        // se queda en cola
      }
    }
  }
}