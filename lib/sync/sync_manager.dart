import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:loteria_app/sync/domain/usecases/sync_all.dart';

class SyncManager {
  final SyncAll syncAll;

  SyncManager(this.syncAll);

  void start() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result[0] != ConnectivityResult.none) {
        syncAll();
      }
    });
  }
}