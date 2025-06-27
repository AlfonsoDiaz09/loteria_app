part of 'init_dependencies.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => ApiSettings.fromEnv());
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  serviceLocator.registerLazySingleton<ClientManager>(() => ClientManager.instance);
  _initApp();
  _initSets();
}

void _initApp(){
  serviceLocator.registerLazySingleton(() => NavigationBloc());
  serviceLocator.registerLazySingleton(() => TimerBloc());
}

void _initSets(){
  serviceLocator
    //Repositories
    ..registerFactory<SetApiRepository>(() => SetApiRepositoryImpl(client: serviceLocator(), apiSettings: serviceLocator()))
    //Usecase
    ..registerFactory(() => ObtenerSets(setApiRepository: serviceLocator()))
    //Bloc
    ..registerLazySingleton(() => SetBloc(obtenerSets: serviceLocator()));
}