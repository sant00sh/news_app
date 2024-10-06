import 'package:equatable/equatable.dart';
import 'package:news_app/domain/entities/news_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
  final List<NewsEntity> news;

  const NewsLoading(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsLoadingMore extends NewsState {
  final List<NewsEntity> news;

  const NewsLoadingMore(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsLoaded extends NewsState {
  final List<NewsEntity> news;

  const NewsLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}

extension NewsStateX on NewsState {
  bool get isLoading => this is NewsLoading;
}
