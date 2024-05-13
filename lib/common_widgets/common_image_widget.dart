import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class CommonImageWidget extends StatelessWidget {
  const CommonImageWidget({
    required this.imageUrl,
    required this.fit,
    super.key,
  });

  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: double.infinity,
      width: double.infinity,
      fit: fit,
      useOldImageOnUrlChange: true,
      errorWidget: (BuildContext context, String url, Object error) {
        return const Icon(Icons.error);
      },
      progressIndicatorBuilder: (
        BuildContext context,
        String string,
        DownloadProgress prgs,
      ) {
        return Center(child: CircularProgressIndicator(value: prgs.progress));
      },
    );
  }
}
