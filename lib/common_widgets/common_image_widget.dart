import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_logger.dart";
import "package:extended_image/extended_image.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

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
    return FadeInImage(
      height: double.infinity,
      width: double.infinity,
      fit: fit,
      image: imageProvider(imageUrl: imageUrl, imageType: imageType),
      placeholderFit: fit,
      placeholder: assetImage(imageType) as ImageProvider,
      fadeInDuration: const Duration(seconds: 1),
      fadeOutDuration: const Duration(seconds: 1),
      imageErrorBuilder: (
        BuildContext context,
        Object error,
        StackTrace? stackTrace,
      ) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
        return Image.asset(assetImage(imageType).assetName);
      },
      placeholderErrorBuilder: (
        BuildContext context,
        Object error,
        StackTrace? stackTrace,
      ) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
        return Image.asset(assetImage(imageType).assetName);
      },
    );
  }
}

ImageProvider<Object> imageProvider({
  required String imageUrl,
  required ImageType imageType,
}) {
  return imageUrl.isURL
      ? ExtendedNetworkImageProvider(
          imageUrl,
          cache: true,
          timeLimit: const Duration(minutes: 10),
        ) as ImageProvider
      : assetImage(imageType) as ImageProvider<Object>;
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
