import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;

  const NetworkImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      placeholder: (context, url) => Icon(
        Icons.photo_size_select_actual_rounded,
        size: 66,
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.image_not_supported_rounded,
        size: 66,
      ),
      width: MediaQuery.of(context).size.width,
      height: 300,
      fit: BoxFit.cover,
    );
  }
}
