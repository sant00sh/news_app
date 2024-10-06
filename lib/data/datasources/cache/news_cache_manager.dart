import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/constants/string_constant.dart';
import 'package:news_app/domain/entities/news_entity.dart';

class NewsCacheManager {
  static Box<dynamic> newsBox = Hive.box(StringConstant.newsBox);

  // Cache news for a specific page
  static Future<void> cacheNewsForPage(
      int page, List<NewsEntity> newsList) async {
    List<Map<String, dynamic>> newsJsonList =
        newsList.map((news) => news.toJson()).toList();
    await newsBox.put('news_page_$page', newsJsonList);
  }

  // Retrieve cached news for a specific page
  static List<NewsEntity>? getCachedNewsForPage(int page) {
    final List<dynamic>? cachedData = newsBox.get('news_page_$page');

    if (cachedData == null) return null;

    try {
      List<Map<String, dynamic>> cachedJsonList =
          cachedData.map((item) => Map<String, dynamic>.from(item)).toList();

      List<NewsEntity> newsEntities = cachedJsonList.map((json) {
        return NewsEntity.fromJson(json);
      }).toList();

      return newsEntities;
    } catch (e) {
      return null;
    }
  }
}
