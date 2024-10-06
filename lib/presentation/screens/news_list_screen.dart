import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/string_constant.dart';
import 'package:news_app/core/utils/app_navigator.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/presentation/cubit/news_cubit.dart';
import 'package:news_app/presentation/cubit/news_state.dart';
import 'package:news_app/presentation/widgets/grid_item.dart';
import 'package:news_app/presentation/widgets/loading_indicator.dart';
import 'news_details_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  NewsListScreenState createState() => NewsListScreenState();
}

class NewsListScreenState extends State<NewsListScreen> {
  late NewsCubit _newsCubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _newsCubit = context.read<NewsCubit>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _newsCubit.fetchNews();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_newsCubit.state.isLoading) {
      _newsCubit.fetchNews(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _builder(),
    );
  }

  PreferredSizeWidget _appBar() => AppBar(title: Text(StringConstant.news));

  Widget _builder() => BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading && state.news.isEmpty) {
            return const LoadingIndicator();
          } else if (state is NewsError) {
            return _errorText(state.message);
          } else if (state is NewsLoaded) {
            final newsList = state.news;
            return _newsGridView(state: state, newsList: newsList);
          } else if (state is NewsLoadingMore) {
            final newsList = state.news;
            return _newsGridView(state: state, newsList: newsList);
          }
          return Container();
        },
      );

  Widget _errorText(String msg) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 44,
            ),
            SizedBox(height: 8),
            Text(
              StringConstant.newsLoadErr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      );

  Widget _newsGridView(
          {required NewsState state, required List<NewsEntity> newsList}) =>
      GridView.builder(
        controller: _scrollController,
        itemCount: newsList.length + (state is NewsLoadingMore ? 1 : 0),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          if (index == newsList.length) {
            return LoadingIndicator();
          }

          return _gridItem(newsList[index]);
        },
      );

  Widget _gridItem(NewsEntity newsItem) => GestureDetector(
        onTap: () => AppNavigator.instance.push(
          NewsDetailsScreen(newsItem: newsItem),
        ),
        child: GridItem(newsItem: newsItem),
      );
}
