import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:news_app/domain/usecases/get_news.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/domain/repositories/news_repository.dart';
import 'package:news_app/core/error/failures.dart';

@GenerateMocks([NewsRepository])
import 'get_news_test.mocks.dart';

void main() {
  late GetNews getNews;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    getNews = GetNews(mockNewsRepository);
  });

  int tPage = 1;
  final tNewsList = [
    NewsEntity(
      uuid: '1',
      title: 'Test News 1',
      description: 'Test Description 1',
      keywords: 'Test1',
      url: 'test1.com',
      imageUrl: 'test1.jpg',
      language: 'en',
      publishedAt: '2022-01-01',
      source: 'Test Source 1',
      categories: ['Test1'],
    ),
    NewsEntity(
      uuid: '2',
      title: 'Test News 2',
      description: 'Test Description 2',
      keywords: 'Test2',
      url: 'test2.com',
      imageUrl: 'test2.jpg',
      language: 'fr',
      publishedAt: '2022-01-02',
      source: 'Test Source 2',
      categories: ['Test2'],
    ),
  ];

  group('GetNews', () {
    test('should get a list of news from the repo', () async {
      when(mockNewsRepository.getNews(any))
          .thenAnswer((_) async => Right(tNewsList));

      tPage++;
      final result = await getNews(tPage);

      expect(result, Right(tNewsList));
      verify(mockNewsRepository.getNews(tPage));
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test('should return a ServerFailure when getting news is unsuccessful',
        () async {
      final tNewsFailure = ServerFailure(message: 'Server Error');
      when(mockNewsRepository.getNews(any))
          .thenAnswer((_) async => Left(tNewsFailure));

      final result = await getNews(tPage);

      expect(result, Left(tNewsFailure));
      verify(mockNewsRepository.getNews(tPage));
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test('should return a NetworkFailure when there is no internet connection',
        () async {
      final tNetworkFailure = NetworkFailure(message: 'No Internet Connection');
      when(mockNewsRepository.getNews(any))
          .thenAnswer((_) async => Left(tNetworkFailure));

      final result = await getNews(tPage);

      expect(result, Left(tNetworkFailure));
      verify(mockNewsRepository.getNews(tPage));
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test('should return an empty list when no news are available', () async {
      when(mockNewsRepository.getNews(any))
          .thenAnswer((_) async => Right<Failure, List<NewsEntity>>([]));

      final result = await getNews(tPage);

      expect(result, isA<Right<Failure, List<NewsEntity>>>());
      expect(result.getOrElse(() => []), isEmpty);
      verify(mockNewsRepository.getNews(tPage));
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test('should return news for different pages', () async {
      final tPage1 = 1;
      final tPage2 = 2;
      final tNewsList1 = [tNewsList[0]];
      final tNewsList2 = [tNewsList[1]];

      when(mockNewsRepository.getNews(tPage1))
          .thenAnswer((_) async => Right(tNewsList1));
      when(mockNewsRepository.getNews(tPage2))
          .thenAnswer((_) async => Right(tNewsList2));

      final result1 = await getNews(tPage1);
      final result2 = await getNews(tPage2);

      expect(result1, Right(tNewsList1));
      expect(result2, Right(tNewsList2));
      verify(mockNewsRepository.getNews(tPage1));
      verify(mockNewsRepository.getNews(tPage2));
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test('should handle invalid page numbers gracefully', () async {
      final tInvalidPage = -1;
      final tNewsFailure = ServerFailure(message: 'Invalid page number');
      when(mockNewsRepository.getNews(tInvalidPage))
          .thenAnswer((_) async => Left(tNewsFailure));

      final result = await getNews(tInvalidPage);

      expect(result, Left(tNewsFailure));
      verify(mockNewsRepository.getNews(tInvalidPage));
      verifyNoMoreInteractions(mockNewsRepository);
    });
  });
}
