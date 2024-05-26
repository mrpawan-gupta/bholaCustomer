import "dart:io";
import "dart:typed_data";

import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:transparent_image/transparent_image.dart";
import "package:video_thumbnail/video_thumbnail.dart";

class AppImageVideoPicker {
  factory AppImageVideoPicker() {
    return _singleton;
  }

  AppImageVideoPicker._internal();
  static final AppImageVideoPicker _singleton = AppImageVideoPicker._internal();

  Future<void> openImageVideoPicker({
    required Function(String filePath) filePathCallback,
    required bool isForVideo,
  }) async {
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            AppLanguageKeys().strActionPerform.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ListTile(
            dense: true,
            leading: const Icon(Icons.camera_alt_outlined),
            title: Text(AppLanguageKeys().strCamera.tr),
            onTap: () async {
              AppNavService().pop();

              final String filePath = await onSelectCamera(
                isForVideo: isForVideo,
              );
              if (filePath.isNotEmpty) {
                final int sizeInBytes = File(filePath).lengthSync();
                final double sizeInMb = sizeInBytes / (1024 * 1024);
                sizeInMb > 20
                    ? AppSnackbar().snackbarFailure(
                        title: "Oops",
                        message: "File size should ne less than 20 MB",
                      )
                    : filePathCallback(filePath);
              } else {}
            },
          ),
          ListTile(
            leading: Icon(
              isForVideo
                  ? Icons.video_collection_outlined
                  : Icons.photo_library_outlined,
            ),
            title: Text(
              isForVideo
                  ? "Video Library"
                  : AppLanguageKeys().strPhotoLibrary.tr,
            ),
            onTap: () async {
              AppNavService().pop();

              final String filePath = await onSelectPhotoLibrary(
                isForVideo: isForVideo,
              );
              if (filePath.isNotEmpty) {
                final int sizeInBytes = File(filePath).lengthSync();
                final double sizeInMb = sizeInBytes / (1024 * 1024);
                sizeInMb > 20
                    ? AppSnackbar().snackbarFailure(
                        title: "Oops",
                        message: "File size should ne less than 20 MB",
                      )
                    : filePathCallback(filePath);
              } else {}
            },
          ),
          const SizedBox(height: 48),
        ],
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }

  Future<String> onSelectCamera({required bool isForVideo}) async {
    String filePath = "";
    final bool hasPerm = await AppPermService().permissionPhotoOrStorage();
    if (hasPerm) {
      final ImagePicker picker = ImagePicker();
      const ImageSource src = ImageSource.camera;

      final XFile file = isForVideo
          ? await picker.pickVideo(source: src) ?? XFile("")
          : await picker.pickImage(source: src) ?? XFile("");

      filePath = file.path;
    } else {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Camera Permission Needed",
      );
    }
    return Future<String>.value(filePath);
  }

  Future<String> onSelectPhotoLibrary({required bool isForVideo}) async {
    String filePath = "";
    final bool hasPerm = await AppPermService().permissionPhotoOrStorage();
    if (hasPerm) {
      final ImagePicker picker = ImagePicker();
      const ImageSource src = ImageSource.gallery;

      final XFile file = isForVideo
          ? await picker.pickVideo(source: src) ?? XFile("")
          : await picker.pickImage(source: src) ?? XFile("");

      filePath = file.path;
    } else {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Photo Library Permission Needed",
      );
    }
    return Future<String>.value(filePath);
  }

  Future<Uint8List> generateThumbnail({required String path}) async {
    final Uint8List value = await VideoThumbnail.thumbnailData(
          video: path,
        ) ??
        kTransparentImage;
    return Future<Uint8List>.value(value);
  }
}
