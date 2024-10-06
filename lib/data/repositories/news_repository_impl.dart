import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/data/datasources/news_remote_data_source.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews(int page) async {
    return await remoteDataSource.getNews(page, 5);
  }
}
