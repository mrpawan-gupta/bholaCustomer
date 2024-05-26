import "package:cached_network_image/cached_network_image.dart";
import "package:customer/utils/app_assets_images.dart";
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
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: double.infinity,
      width: double.infinity,
      fit: fit,
      useOldImageOnUrlChange: true,
      errorWidget: (BuildContext context, String url, Object error) {
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
        return Image.asset(value);
      },
      placeholder: (BuildContext context, String url) {
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
        return Image.asset(value);
      },
    );
  }
}
