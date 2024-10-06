import 'package:flutter/material.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:news_app/core/constants/string_constant.dart';
import 'package:news_app/core/utils/extensions.dart';
import 'package:news_app/core/utils/utilities.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/presentation/widgets/network_image_widget.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsEntity newsItem;

  const NewsDetailsScreen({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(newsItem.title ?? StringConstant.newsDetails)),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageWidget(context),
            15.toVerticalSpace,
            Text(newsItem.description ?? ""),
            30.toVerticalSpace,
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => Utilities.launchWeb(newsItem.url),
                child: Text(
                  StringConstant.openInBrowser,
                ),
              ),
            )
          ],
        ),
      );

  Widget _imageWidget(BuildContext context) => GestureDetector(
        onTap: () {
          final imageProvider = Image.network(newsItem.imageUrl ?? "").image;
          showImageViewer(context, imageProvider, onViewerDismissed: () {});
        },
        child: NetworkImageWidget(imageUrl: newsItem.imageUrl),
      );
}
