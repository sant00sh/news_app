import 'package:dartz/dartz.dart';
import 'package:news_app/core/env/env.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/data/services/news_api_service.dart';
import 'package:news_app/domain/entities/news_entity.dart';

import 'cache/news_cache_manager.dart';

abstract class NewsRemoteDataSource {
  Future<Either<Failure, List<NewsEntity>>> getNews(
      int startPage, int pagesToFetch);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final NewsApiService apiService;

  NewsRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews(
      int startPage, int pagesToFetch) async {
    try {
      List<NewsEntity> combinedNews = [];

      for (int i = 0; i < pagesToFetch; i++) {
        int currentPage = startPage + i;

        List<NewsEntity>? cachedNews =
            NewsCacheManager.getCachedNewsForPage(currentPage);

        if (cachedNews != null && cachedNews.isNotEmpty) {
          combinedNews.addAll(cachedNews);
        } else {
          final apiResponse =
              await apiService.getTopNews(Env.apiKey, 'us', currentPage);

          List<NewsEntity> newsFromApi =
              apiResponse.data.map((news) => news).toList();

          if (newsFromApi.isNotEmpty) {
            await NewsCacheManager.cacheNewsForPage(currentPage, newsFromApi);

            combinedNews.addAll(newsFromApi);
          }
        }
      }

      return Right(combinedNews);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
