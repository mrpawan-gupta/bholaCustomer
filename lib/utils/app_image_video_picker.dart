import "dart:io";
import "dart:typed_data";

import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:media_info/media_info.dart";
import "package:path_provider/path_provider.dart";
import "package:transparent_image/transparent_image.dart";
import "package:video_thumbnail/video_thumbnail.dart";

class AppImageVideoPicker {
  factory AppImageVideoPicker() {
    return _singleton;
  }

  AppImageVideoPicker._internal();
  static final AppImageVideoPicker _singleton = AppImageVideoPicker._internal();

  final ImagePicker _picker = ImagePicker();
  final MediaInfo _mediaInfo = MediaInfo();

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

                if (sizeInMb > 20) {
                  AppSnackbar().snackbarFailure(
                    title: "Oops",
                    message: "File size should ne less than 20 MB",
                  );
                } else {
                  Map<String, dynamic> info = <String, dynamic>{};

                  info = await _mediaInfo.getMediaInfo(filePath);

                  AppLogger().info(message: "getMediaInfo: $info");

                  if (info.containsKey("durationMs")) {
                    final num durationMs = info["durationMs"];
                    final num durationinMinutes = durationMs / 60000;

                    if (durationinMinutes > 5) {
                      AppSnackbar().snackbarFailure(
                        title: "Oops",
                        message: "File duration should ne less than 5 minutes",
                      );
                    } else {
                      filePathCallback(filePath);
                    }
                  } else {
                    filePathCallback(filePath);
                  }
                }
              } else {}
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

                  if (info.containsKey("durationMs")) {
                    final num durationMs = info["durationMs"];
                    final num durationinMinutes = durationMs / 60000;

                    if (durationinMinutes > 5) {
                      AppSnackbar().snackbarFailure(
                        title: "Oops",
                        message: "File duration should ne less than 5 minutes",
                      );
                    } else {
                      filePathCallback(filePath);
                    }
                  } else {
                    filePathCallback(filePath);
                  }
                }
              } else {}
            },
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 32),
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
}

Future<Uint8List> generateThumbnail({required String path}) async {
  Uint8List value = kTransparentImage;

  try {
    value = await VideoThumbnail.thumbnailData(
          video: path,
        ) ??
        kTransparentImage;
  } on Exception catch (error, stackTrace) {
    AppLogger().error(
      message: "Exception caught",
      error: error,
      stackTrace: stackTrace,
    );
  } finally {}

  return Future<Uint8List>.value(value);
}

Future<String> thumbnailFile({required String path}) async {
  String value = "";

  try {
    value = await VideoThumbnail.thumbnailFile(
          video: path,
          thumbnailPath: (await getTemporaryDirectory()).path,
        ) ??
        "";
  } on Exception catch (error, stackTrace) {
    AppLogger().error(
      message: "Exception caught",
      error: error,
      stackTrace: stackTrace,
    );
  } finally {}

  return Future<String>.value(value);
}
