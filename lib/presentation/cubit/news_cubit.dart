import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/domain/usecases/get_news.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNews getNewsUseCase;

  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasReachedEnd = false;
  final List<NewsEntity> _newsList = [];

  NewsCubit(this.getNewsUseCase) : super(NewsInitial());

  Future<void> fetchNews({bool isLoadMore = false}) async {
    if (_isLoading || _hasReachedEnd) return;

    _isLoading = true;

    if (!isLoadMore) {
      emit(NewsLoading(_newsList));
    } else {
      emit(NewsLoadingMore(_newsList));
    }

    final failureOrNews = await getNewsUseCase(_currentPage);
    failureOrNews.fold(
      (failure) => emit(NewsError(failure.message ?? "")),
      (news) {
        if (news.isEmpty) {
          _hasReachedEnd = true;
        } else {
          _newsList.addAll(news);
          _currentPage += 5;
          emit(NewsLoaded(_newsList));
        }
      },
    );

    _isLoading = false;
  }
}
