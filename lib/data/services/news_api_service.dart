import 'package:news_app/core/constants/api_constant.dart';
import 'package:news_app/data/models/news_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: APIConstant.baseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET(APIConstant.topNews)
  Future<NewsResponse> getTopNews(
    @Query("api_token") String apiKey,
    @Query("locale") String locale,
    @Query("page") int page,
  );
}
