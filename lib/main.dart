import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/constants/string_constant.dart';
import 'package:news_app/core/utils/app_navigator.dart';
import 'domain/entities/news_entity.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/cubit/news_cubit.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NewsEntityAdapter());
  await Hive.openBox(StringConstant.newsBox);

  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I<NewsCubit>(),
        ),
      ],
      child: MaterialApp(
        title: StringConstant.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: AppNavigator.instance.navigatorKey,
        home: SplashScreen(),
      ),
    );
  }
}
