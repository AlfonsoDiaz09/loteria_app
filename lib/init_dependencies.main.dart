part of 'init_dependencies.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => ApiSettings.fromEnv());
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  serviceLocator.registerLazySingleton<ClientManager>(() => ClientManager.instance);
  _initApp();
  _initSetCards();
}

void _initApp(){
  serviceLocator.registerLazySingleton(() => NavigationBloc());
  serviceLocator.registerLazySingleton(() => TimerBloc());
}

void _initSetCards(){
  serviceLocator
    //Repositories
    ..registerFactory<SetApiRepository>(() => SetApiRepositoryImpl(client: serviceLocator(), apiSettings: serviceLocator()))
    ..registerFactory<CardApiRepository>(() => CardApiRepositoryImpl(apiSettings: serviceLocator(), client: serviceLocator()))
    //Usecase
    ..registerFactory(() => ObtenerDefaultSets(setApiRepository: serviceLocator(), cardApiRepository: serviceLocator()))
    ..registerFactory(() => ObtenerCards(cardApiRepository: serviceLocator()))
    //Bloc
    ..registerLazySingleton(() => SetBloc(obtenerDefaultSets: serviceLocator()))
    ..registerLazySingleton(() => DeckBloc());
}