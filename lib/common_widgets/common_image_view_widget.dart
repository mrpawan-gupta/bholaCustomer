import "package:cached_network_image/cached_network_image.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/utils/app_logger.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:path/path.dart";
import "package:photo_view/photo_view.dart";

class ImageView extends StatelessWidget {
  const ImageView({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(basename(imageUrl)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          imageProvider: imageUrl.isURL
              ? CachedNetworkImageProvider(
                  imageUrl,
                  errorListener: (Object error) {
                    AppLogger().error(
                      message: "Exception caught",
                      error: error,
                    );
                  },
                ) as ImageProvider
              : assetImage(ImageType.image) as ImageProvider,
        ),
      ),
    );
  }
}
