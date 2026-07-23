import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:bookia/feature/auth/data/repository/auth_repo_impl.dart';
import 'package:bookia/feature/auth/domain/repo/auth_repo.dart';
import 'package:bookia/feature/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/feature/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocatorSetup() async {
  DioProvider.init();
  await SharedPref.init();
  // register data sources

  getIt.registerLazySingleton<AuthDataSource>(() => AuthRemoteDataSourceImpl());

  // register repositories

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authRemoteDataSource: getIt()),
  );

  // register use cases

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepo: getIt()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(authRepo: getIt()),
  );

  // register cubits

  getIt.registerFactory<AuthCubit>(() => AuthCubit());

  // register shared objects
}
