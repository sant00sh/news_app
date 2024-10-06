import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getNews(int page);
}