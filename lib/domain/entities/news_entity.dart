import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'news_entity.freezed.dart';
part 'news_entity.g.dart';

@freezed
@HiveType(typeId: 0)
class NewsEntity with _$NewsEntity {
  const factory NewsEntity({
    @HiveField(0) @JsonKey(name: 'uuid') String? uuid,
    @HiveField(1) @JsonKey(name: 'title') String? title,
    @HiveField(2) @JsonKey(name: 'description') String? description,
    @HiveField(3) @JsonKey(name: 'keywords') String? keywords,
    @HiveField(4) @JsonKey(name: 'url') String? url,
    @HiveField(5) @JsonKey(name: 'image_url') String? imageUrl,
    @HiveField(6) @JsonKey(name: 'language') String? language,
    @HiveField(7) @JsonKey(name: 'published_at') String? publishedAt,
    @HiveField(8) @JsonKey(name: 'source') String? source,
    @HiveField(9) @JsonKey(name: 'categories') List<String>? categories,
  }) = _NewsEntity;

  factory NewsEntity.fromJson(Map<String, dynamic> json) =>
      _$NewsEntityFromJson(json);
}
