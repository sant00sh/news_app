import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app/presentation/cubit/news_cubit.dart';
import 'data/datasources/cache/news_cache_manager.dart';
import 'domain/repositories/news_repository.dart';
import 'domain/usecases/get_news.dart';
import 'data/repositories/news_repository_impl.dart';
import 'data/datasources/news_remote_data_source.dart';
import 'data/services/news_api_service.dart';
import 'core/network/dio_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register Dio
  sl.registerLazySingleton(() => DioHelper(Dio()));

  // Register Retrofit API Service
  sl.registerLazySingleton(() => NewsApiService(sl<DioHelper>().dio));

  // Register Cache Manager
  sl.registerLazySingleton(() => NewsCacheManager());

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
          () => NewsRemoteDataSourceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<NewsRepository>(
          () => NewsRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));

  // Cubit
  sl.registerFactory(() => NewsCubit(sl()));
}
