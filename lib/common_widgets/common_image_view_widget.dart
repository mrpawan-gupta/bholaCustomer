import "package:customer/common_widgets/common_image_widget.dart";
import "package:flutter/material.dart";
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
          imageProvider: imageProvider(
            imageUrl: imageUrl,
            imageType: ImageType.image,
          ),
        ),
      ),
    );
  }
}
