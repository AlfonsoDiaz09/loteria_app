import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:loteria_app/core/constants/database_constants.dart';
import 'package:loteria_app/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbIsolate {
  static late SendPort _sendport;

  static final Completer<Database> _localDbCompleter = Completer<Database>();

  static Future<void> initialize(RootIsolateToken rootToken) async {
    try {
      logger.i('Initializing database isolate...');
      final initPort = ReceivePort();

      await Isolate.spawn(
          _databaseIsolate,
          _IsolateInitParams(
            initPort.sendPort,
            rootToken));
      _sendport = await initPort.first;
      logger.i('Database isolate initialized successfully');
    } catch (e, stack) {
      logger.e('Failed to initialize database isolate', error: e, stackTrace: stack);
      rethrow;
    }
  }

  static Future<Database> get localDatabase async {
    if (!_localDbCompleter.isCompleted) {
      final responsePort = ReceivePort();
      _sendport.send({
        'type': 'getDatabase',
        'dbName': 'local',
        'responsePort': responsePort.sendPort});
      final response = await responsePort.first;
      responsePort.close();

      if (response is Database) {
        _localDbCompleter.complete(response);
      } else {
        _localDbCompleter.completeError(response as Exception);
      }
    }
    return _localDbCompleter.future;
  }

  static Future<void> _databaseIsolate(_IsolateInitParams params) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(params.rootToken);

    final receivePort = ReceivePort();
    params.initPort.send(receivePort.sendPort);

    Database? localDb;
    await for (final message in receivePort) {
      if (message is Map) {
        final String type = message['type'];
        final String? dbName = message['dbName'];
        final SendPort? callback = message['callback'];
        
        try {
          if (type == 'getDatabase') {
            final SendPort responsePort = message['responsePort'];
            final appDir = await getApplicationDocumentsDirectory();
            final databasesPath = appDir.path;
            
            if (dbName == 'local' && localDb != null) {
              final path = join(databasesPath, 'databases', DatabaseConstants.localDB);
              final parentDir = Directory(dirname(path));
              if (!await parentDir.exists()) {
                await parentDir.create(recursive: true);
              }
              
              localDb = await openDatabase(
                  path,
                  version: DatabaseConstants.localDBVersion,
                  onCreate: (Database dbLocal, int version) async {
                    await dbLocal.execute('CREATE TABLE IF NOT EXISTS ${DatabaseConstants.setsTable} (id TEXT PRIMARY KEY, name TEXT, description TEXT, session_id TEXT, is_default BOOLEAN, is_synced BOOLEAN, created_at TEXT, updated_at TEXT, deleated_at TEXT)');
                    await dbLocal.execute('CREATE TABLE IF NOT EXISTS ${DatabaseConstants.cardsTable} (id TEXT PRIMARY KEY, name TEXT, image_url TEXT, number INTEGER, is_synced BOOLEAN, set_id TEXT, created_at TEXT, updated_at TEXT, deleated_at TEXT)');
                    await dbLocal.execute('CREATE TABLE IF NOT EXISTS ${DatabaseConstants.syncQueueTable} (id TEXT PRIMARY KEY, table_name TEXT, type TEXT, data TEXT, created_at TEXT)');
                  });
              responsePort.send(localDb);
            }
          }
        } catch (e, stack) {
          logger.e('Database operation failed', error: e, stackTrace: stack);
          if (callback != null) {
            callback.send(e);
          }
        }
      }
    }
  }
}

class _IsolateInitParams {
  final SendPort initPort;
  final RootIsolateToken rootToken;

  _IsolateInitParams(this.initPort, this.rootToken);
}