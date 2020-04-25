import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:jptapp/core/platform/network_info.dart';
import 'package:jptapp/features/list_items_data/presentation/bloc/bloc/list_items_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/list_items_data/data/datasources/list_items_local_data_source.dart';
import 'features/list_items_data/data/datasources/list_items_remote_data_source.dart';
import 'features/list_items_data/data/repositories/list_item_data_repository_impl.dart';
import 'features/list_items_data/domain/repositories/list_items_data_repository.dart';
import 'features/list_items_data/domain/use_cases/get_list_items_data.dart';
import 'injection_container.iconfig.dart';


final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
        () =>
        ListItemsBloc(
          getItemDataList: sl(),
        ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetItemListData(sl()));
  // Repository
  sl.registerLazySingleton<ListItemsDataRepository>(
        () =>
        ListItemDataRepositoryImpl(
          localDataSource: sl(),
          networkInfo: sl(),
          remoteDataSource: sl(),
        ),
  );
  // Data sources
  sl.registerLazySingleton<ListItemsRemoteDataSource>(
        () => ListItemsRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ListItemsLocalDataSource>(
        () => ListItemsLocalDataSourceImpl(sharedPreferences: sl()),
  );
  //! Core
  sl.registerLazySingleton<NetWorkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

@injectableInit
void configureInjection(String env) {
  $initGetIt(sl, environment: env);
}
