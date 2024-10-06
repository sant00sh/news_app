import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/domain/entities/news_entity.dart';

part 'news_response.freezed.dart';
part 'news_response.g.dart';

@freezed
class NewsResponse with _$NewsResponse {
  const factory NewsResponse({
    required Meta meta,
    required List<NewsEntity> data,
  }) = _NewsResponse;

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    required int found,
    required int returned,
    required int limit,
    required int page,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
