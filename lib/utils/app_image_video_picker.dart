import "dart:io";
import "dart:typed_data";

import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:media_info/media_info.dart" as mi;
import "package:transparent_image/transparent_image.dart";
import "package:video_compress/video_compress.dart";

class AppImageVideoPicker {
  factory AppImageVideoPicker() {
    return _singleton;
  }

  AppImageVideoPicker._internal();
  static final AppImageVideoPicker _singleton = AppImageVideoPicker._internal();

  final ImagePicker _picker = ImagePicker();
  final mi.MediaInfo _mediaInfo = mi.MediaInfo();

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
              await validateMediaInfo(
                filePath: filePath,
                filePathCallback: filePathCallback,
              );
            },
          ),
          ListTile(
            dense: true,
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
              await validateMediaInfo(
                filePath: filePath,
                filePathCallback: filePathCallback,
              );
            },
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 32),
        ],
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
      enableDrag: true,
    );
    return Future<void>.value();
  }

  Future<String> onSelectCamera({required bool isForVideo}) async {
    String filePath = "";
    final bool hasPerm = await AppPermService().permissionPhotoOrStorage();
    if (hasPerm) {
      const ImageSource src = ImageSource.camera;
      final XFile file = isForVideo
          ? await _picker.pickVideo(source: src) ?? XFile("")
          : await _picker.pickImage(source: src) ?? XFile("");
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
      const ImageSource src = ImageSource.gallery;
      final XFile file = isForVideo
          ? await _picker.pickVideo(source: src) ?? XFile("")
          : await _picker.pickImage(source: src) ?? XFile("");
      filePath = file.path;
    } else {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Photo Library Permission Needed",
      );
    }
    return Future<String>.value(filePath);
  }

  Future<void> validateMediaInfo({
    required String filePath,
    required Function(String filePath) filePathCallback,
  }) async {
    if (filePath.isNotEmpty) {
      final int sizeInBytes = File(filePath).lengthSync();
      final double sizeInMb = sizeInBytes / (1024 * 1024);

      if (sizeInMb > 20) {
        AppSnackbar().snackbarFailure(
          title: "Oops",
          message: "File size should ne less than 20 MB",
        );
      } else {
        Map<String, dynamic> info = <String, dynamic>{};
        info = await _mediaInfo.getMediaInfo(filePath);

        AppLogger().info(message: "getMediaInfo: $info");

        final bool contains = info.containsKey("durationMs");
        if (contains) {
          final num durationMs = info["durationMs"] ?? 0;
          final num durationinMinutes = durationMs / 60000;

          durationinMinutes > 5
              ? AppSnackbar().snackbarFailure(
                  title: "Oops",
                  message: "File duration should ne less than 5 minutes",
                )
              : filePathCallback(filePath);
        } else {
          filePathCallback(filePath);
        }
      }
    } else {}

    return Future<void>.value();
  }
}

Future<Uint8List> generateThumbnail({required String path}) async {
  Uint8List value = kTransparentImage;
  try {
    value = await VideoCompress.getByteThumbnail(path) ?? kTransparentImage;
  } on Exception catch (error, stackTrace) {
    AppLogger().error(
      message: "Exception caught",
      error: error,
      stackTrace: stackTrace,
    );
  } finally {}
  return Future<Uint8List>.value(value);
}

Future<File> getSingleFile({required String url}) async {
  File file = File("");
  try {
    file = await DefaultCacheManager().getSingleFile(url);
  } on Exception catch (error, stackTrace) {
    AppLogger().error(
      message: "Exception caught",
      error: error,
      stackTrace: stackTrace,
    );
  } finally {}
  return Future<File>.value(file);
}
