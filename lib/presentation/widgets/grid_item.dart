import 'package:flutter/material.dart';
import 'package:news_app/domain/entities/news_entity.dart';
import 'package:news_app/presentation/widgets/network_image_widget.dart';

class GridItem extends StatelessWidget {
  final NewsEntity newsItem;

  const GridItem({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: NetworkImageWidget(imageUrl: newsItem.imageUrl),
            ),
          ),
          Flexible(
            child: Text(
              newsItem.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
