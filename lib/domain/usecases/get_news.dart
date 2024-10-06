import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<Either<Failure, List<NewsEntity>>> call(int page) async {
    return await repository.getNews(page);
  }
}
