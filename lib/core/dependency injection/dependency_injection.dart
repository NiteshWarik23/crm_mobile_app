import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:crm_mobile_app/modules/login/data/repositories/login_repository.dart';
import 'package:crm_mobile_app/modules/login/data/repositories/login_repository_impl.dart';
import 'package:crm_mobile_app/modules/login/data/services/login_api.dart';
import 'package:crm_mobile_app/modules/login/domain/usecase/login_usecase.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

//Example of different types of registration in GetIt
// registerSingleton<T>()
// Registers a single instance of a class that is always the same.
// Best for services like API clients or databases.

//getIt.registerSingleton<Dio>(Dio());

// registerLazySingleton<T>()
// Registers a singleton only when it's first needed.
// Saves memory by delaying initialization.
// Best for services that are not always needed.

//getIt.registerLazySingleton<LoginApi>(() => LoginApi(getIt<Dio>()));

// registerFactory<T>()
// Creates a new instance every time it’s requested.
// Best for BLoCs, where each screen needs a fresh instance.

//getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<LoginUseCase>()));

// registerSingletonWithDependencies<T>()
// Creates a singleton after ensuring its dependencies are ready.
// Best for services that depend on other services.

// getIt.registerSingletonWithDependencies<LoginRepositoryImpl>(
//   () => LoginRepositoryImpl(getIt<LoginApi>()),
//   dependsOn: [LoginApi],
// );

// registerFactoryAsync<T>()
// Registers a factory that returns a Future, useful for async initialization.

// getIt.registerFactoryAsync<Dio>(() async {
//   final dio = Dio();
//   // Perform async setup if needed
//   return dio;
// });

final locator = GetIt.instance;

void init() {
//Common Module Dependencies
  locator.registerLazySingleton<DioClient>(() => DioClient());

// Login Module Dependencies
//API Services
  locator.registerLazySingleton<LoginAPi>(() => LoginAPiImpl(locator()));
//Repositories
  locator.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(locator()));
//Use Cases
  locator.registerLazySingleton<LoginUsecase>(() => LoginUsecase(locator()));
//Bloc or ViewModels
  locator.registerFactory<LoginBloc>(() => LoginBloc(locator()));

// Dashboard Module Dependencies
//API Services
//Repositories
//UseCaase
//Bloc or ViewModel
  locator.registerFactory<BottomNavBloc>(() => BottomNavBloc());
}
