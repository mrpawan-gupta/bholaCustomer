import "package:cached_network_image/cached_network_image.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_logger.dart";
import "package:flutter/material.dart";

enum ImageType { user, image, video }

class CommonImageWidget extends StatelessWidget {
  const CommonImageWidget({
    required this.imageUrl,
    required this.fit,
    required this.imageType,
    super.key,
  });

  final String imageUrl;
  final BoxFit fit;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageUrl.isEmpty
              ? assetImage(imageType) as ImageProvider
              : CachedNetworkImageProvider(
                  imageUrl,
                  errorListener: (Object error) {
                    AppLogger().error(
                      message: "Exception caught",
                      error: error,
                    );
                  },
                ) as ImageProvider,
          fit: fit,
          isAntiAlias: true,
          onError: (Object error, StackTrace? stackTrace) {
            AppLogger().error(
              message: "Exception caught",
              error: error,
              stackTrace: stackTrace,
            );
          },
        ),
      ),
    );
  }

  AssetImage assetImage(ImageType imageType) {
    String value = "";

    switch (imageType) {
      case ImageType.user:
        value = AppAssetsImages().userPlaceholder;
        break;
      case ImageType.image:
        value = AppAssetsImages().imagePlaceholder;
        break;
      case ImageType.video:
        value = AppAssetsImages().videoPlaceholder;
        break;
    }

    return AssetImage(value);
  }
}
