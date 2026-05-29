part of 'init_dependencies.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => ApiSettings.fromEnv());
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  serviceLocator.registerLazySingleton<ClientManager>(
          () => ClientManager.instance);
  await _initApp();
  _initGame();
  _initCards();
  _initSets();
  _initSync();
}

Future<void> _initApp() async {
  serviceLocator
    //UUID (external)
    ..registerLazySingleton(() => const Uuid())
    //ID GENERATOR (core)
    ..registerLazySingleton<IdGenerator>(() => UuidGenerator(serviceLocator()))
    //Bloc
    ..registerLazySingleton(() => NavigationBloc());
}

void _initGame(){
  serviceLocator
  //Bloc
    ..registerLazySingleton(() => TimerBloc())
    ..registerLazySingleton(() => DeckBloc(setBloc: serviceLocator()));
}

void _initCards(){
  serviceLocator
    //Datasources
    ..registerFactory<CardLocalDatasource>(
          () => CardLocalDatasourceImpl())
    ..registerFactory<CardRemoteDatasource>(
          () => CardRemoteDatasourceImpl(apiSettings: serviceLocator(),
              client: serviceLocator()))
    //Repositories
    ..registerFactory<CardRepository>(() => CardRepositoryImpl(
          localCard: serviceLocator(), remoteCard: serviceLocator()))
    //Usecase
    ..registerFactory(() => GetCardsBySet(repository: serviceLocator()))
    ..registerFactory(() => UpdateCard(repository: serviceLocator()))
    //Bloc
    ..registerLazySingleton(() => CardBloc(getCardsBySet: serviceLocator()));
}

void _initSets(){
  serviceLocator
  //Datasources
    ..registerFactory<SetLocalDatasource>(
          () => SetLocalDatasourceImpl())
    ..registerFactory<SetRemoteDatasource>(
          () => SetRemoteDatasourceImpl(apiSettings: serviceLocator(),
              client: serviceLocator()))
  //Repositories
    ..registerFactory<SetRepository>(() => SetRepositoryImpl(
          remoteSet: serviceLocator(), remoteCard: serviceLocator(),
          localSet: serviceLocator()))
  //Usecase
    ..registerFactory(() => GetAllSets(repository: serviceLocator()))
    ..registerFactory(() => GetSetsWithCards(repository: serviceLocator()))
  //Bloc
    ..registerLazySingleton(() => SetBloc(getSetsWithCards: serviceLocator()));
}

void _initSync(){
  serviceLocator
  //Datasources
    ..registerFactory<SyncQueueDatasource>(
          () => SyncQueueDatasourceImpl())
  //Repositories
    ..registerFactory<SyncRepository>(() => SyncRepositoryImpl(
          localSync: serviceLocator(), idGenerator: serviceLocator()))
  //Usecase
    ..registerFactory(() => SyncAll(repository: serviceLocator()));
}
