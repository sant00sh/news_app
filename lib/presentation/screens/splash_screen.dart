import 'package:flutter/material.dart';
import 'package:news_app/core/constants/string_constant.dart';
import 'package:news_app/core/utils/app_navigator.dart';
import 'package:news_app/core/utils/extensions.dart';
import 'package:news_app/presentation/widgets/loading_indicator.dart';
import 'news_list_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      AppNavigator.instance.pushAndRemoveUntil(NewsListScreen());
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const LoadingIndicator(),
          30.toVerticalSpace,
          Text(
            StringConstant.loading,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          50.toVerticalSpace,
        ],
      ),
    );
  }
}
