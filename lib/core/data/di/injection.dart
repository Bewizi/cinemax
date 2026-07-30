import 'package:cinemax/core/data/api_client.dart';
import 'package:cinemax/features/Auth/bloc/auth_bloc.dart';
import 'package:cinemax/features/Auth/data/auth_data.dart';
import 'package:cinemax/features/Auth/domain/auth_repository.dart';
import 'package:cinemax/features/Explore/bloc/explore_bloc.dart';
import 'package:cinemax/features/Explore/data/movie_data.dart';
import 'package:cinemax/features/Explore/domain/movie_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  // 1. Core Data
  sl
    ..registerLazySingleton<ApiClient>(ApiClient.new)
    ..registerLazySingleton<AuthRepository>(() => AuthData(sl<ApiClient>()))
    ..registerLazySingleton<MovieRepository>(() => MovieData(sl<ApiClient>()))
    // 2. Repositories
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        sl<AuthRepository>(),
      )..add(const AuthCheckRequested()), // Injects the ApiClient automatically
    )
    // As you add features, add them here:
    ..registerLazySingleton<ExploreBloc>(
      () => ExploreBloc(sl<MovieRepository>()),
    );
}
