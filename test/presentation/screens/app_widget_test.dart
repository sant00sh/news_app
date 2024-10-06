import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/cubit/news_cubit.dart';
import 'package:news_app/presentation/cubit/news_state.dart';
import 'package:news_app/presentation/screens/splash_screen.dart';
import 'package:news_app/presentation/screens/news_list_screen.dart';
import 'package:news_app/presentation/screens/news_details_screen.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/core/utils/app_navigator.dart';

@GenerateMocks([NewsCubit, AppNavigator])
import 'app_widget_test.mocks.dart';

void main() {
  late MockNewsCubit mockNewsCubit;
  late MockAppNavigator mockAppNavigator;

  setUp(() {
    mockNewsCubit = MockNewsCubit();
    mockAppNavigator = MockAppNavigator();
    AppNavigator.instance = mockAppNavigator;
  });

  testWidgets('SplashScreen should display loading indicator and text',
      (WidgetTester tester) async {
    when(mockAppNavigator.navigatorKey).thenReturn(GlobalKey<NavigatorState>());
    when(mockAppNavigator.pushAndRemoveUntil(any)).thenAnswer((_) async {});

    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading..'), findsOneWidget);

    await tester.pump(Duration(seconds: 1));

    verify(mockAppNavigator.pushAndRemoveUntil(any)).called(1);
  });

  testWidgets('NewsListScreen should display news items when loaded',
      (WidgetTester tester) async {
    final newsList = [
      NewsEntity(title: 'Test News 1', description: 'Description 1'),
      NewsEntity(title: 'Test News 2', description: 'Description 2'),
    ];

    when(mockNewsCubit.state).thenReturn(NewsLoaded(newsList));
    when(mockNewsCubit.stream)
        .thenAnswer((_) => Stream.value(NewsLoaded(newsList)));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<NewsCubit>.value(
          value: mockNewsCubit,
          child: NewsListScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('News'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Test News 1'), findsOneWidget);
    expect(find.text('Test News 2'), findsOneWidget);
  });

  testWidgets('NewsListScreen should display error message when failed to load',
      (WidgetTester tester) async {
    when(mockNewsCubit.state).thenReturn(NewsError('Failed to load news'));
    when(mockNewsCubit.stream)
        .thenAnswer((_) => Stream.value(NewsError('Failed to load news')));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<NewsCubit>.value(
          value: mockNewsCubit,
          child: NewsListScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Failed to load news, please check after sometime!'),
        findsOneWidget);
  });

  testWidgets('NewsDetailsScreen should display news details',
      (WidgetTester tester) async {
    final newsItem = NewsEntity(
      title: 'Test News',
      description: 'Test Description',
      url: 'https://example.com',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: NewsDetailsScreen(newsItem: newsItem),
      ),
    );

    expect(find.text('Test News'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    expect(find.text('Open in Browser'), findsOneWidget);
  });

  testWidgets('Navigation from SplashScreen to NewsListScreen',
      (WidgetTester tester) async {
    when(mockAppNavigator.navigatorKey).thenReturn(GlobalKey<NavigatorState>());
    when(mockAppNavigator.pushAndRemoveUntil(any)).thenAnswer((_) async {});

    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    await tester.pump(Duration(seconds: 1));

    verify(mockAppNavigator.pushAndRemoveUntil(any)).called(1);
  });
}
