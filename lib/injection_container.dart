import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_studing/core/network/network_info.dart';
import 'package:tdd_studing/core/util/input_converter.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_local_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_remote_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/repositories/hero_info_repository_imp.dart';
import 'package:tdd_studing/features/hero_info/domain/repositories/hero_info_repository.dart';
import 'package:tdd_studing/features/hero_info/domain/usecases/get_hero.dart';
import 'package:tdd_studing/features/hero_info/domain/usecases/get_list_of_heroes.dart';
import 'package:tdd_studing/features/hero_info/presentation/Bloc/bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // features - Hero info
  //--Bloc--
  sl.registerFactory(
    () => HeroInfoBloc(
      byId: sl(),
      randomHero: sl(),
      inputConverter: sl(),
    ),
  );
  //Use cases
  sl.registerLazySingleton(() => GetHeroById(sl()));
  sl.registerLazySingleton(() => GetRandomHero(sl()));

  //Repository
  sl.registerLazySingleton<HeroInfoRepository>(
    () => HeroInfoRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<HeroInfoLocalDataSource>(
      () => HeroInfoLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<HeroInfoRemoteDataSource>(
      () => HeroInfoRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
