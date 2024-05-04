import "dart:io";

import "package:customer/utils/app_logger.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:get/get.dart";
import "package:location/location.dart" as loc;
import "package:permission_handler/permission_handler.dart";

class AppPermService extends GetxService {
  factory AppPermService() {
    return _singleton;
  }

  AppPermService._internal();
  static final AppPermService _singleton = AppPermService._internal();

  Future<bool> permissionLocation() async {
    bool hasLocationPermission = false;
    final PermissionStatus try0 = await Permission.location.status;
    if (try0 == PermissionStatus.granted) {
      hasLocationPermission = true;
    } else {
      final PermissionStatus try1 = await Permission.location.request();
      if (try1 == PermissionStatus.granted) {
        hasLocationPermission = true;
      } else {}
    }
    AppLogger().info(message: "Location perm: $hasLocationPermission");
    return Future<bool>.value(hasLocationPermission);
  }

  Future<bool> serviceLocation() async {
    bool isServiceEnabled = false;
    final bool try0 = await loc.Location().serviceEnabled();
    if (try0 == true) {
      isServiceEnabled = true;
    } else {
      final bool try1 = await loc.Location().requestService();
      if (try1 == true) {
        isServiceEnabled = true;
      } else {}
    }
    AppLogger().info(message: "Location service: $isServiceEnabled");
    return Future<bool>.value(isServiceEnabled);
  }

  Future<bool> permissionNotification() async {
    bool hasNotificationPermission = false;
    final PermissionStatus try0 = await Permission.notification.status;
    if (try0 == PermissionStatus.granted) {
      hasNotificationPermission = true;
    } else {
      final PermissionStatus try1 = await Permission.notification.request();
      if (try1 == PermissionStatus.granted) {
        hasNotificationPermission = true;
      } else {}
    }
    AppLogger().info(message: "Notification perm: $hasNotificationPermission");
    return Future<bool>.value(hasNotificationPermission);
  }

  Future<bool> permissionPhotos() async {
    bool hasPhotosPermission = false;
    final PermissionStatus try0 = await Permission.photos.status;
    if (try0 == PermissionStatus.granted) {
      hasPhotosPermission = true;
    } else {
      final PermissionStatus try1 = await Permission.photos.request();
      if (try1 == PermissionStatus.granted) {
        hasPhotosPermission = true;
      } else {}
    }
    AppLogger().info(message: "Photos perm: $hasPhotosPermission");
    return Future<bool>.value(hasPhotosPermission);
  }

  Future<bool> permissionStorage() async {
    bool hasStoragePermission = false;
    final PermissionStatus try0 = await Permission.storage.status;
    if (try0 == PermissionStatus.granted) {
      hasStoragePermission = true;
    } else {
      final PermissionStatus try1 = await Permission.storage.request();
      if (try1 == PermissionStatus.granted) {
        hasStoragePermission = true;
      } else {}
    }
    AppLogger().info(message: "Storage perm: $hasStoragePermission");
    return Future<bool>.value(hasStoragePermission);
  }

  Future<bool> permissionCalendar() async {
    bool hasCalendarPermission = false;
    final PermissionStatus try0 = await Permission.calendarFullAccess.status;
    if (try0 == PermissionStatus.granted) {
      hasCalendarPermission = true;
    } else {
      final PermissionStatus try1 =
          await Permission.calendarFullAccess.request();
      if (try1 == PermissionStatus.granted) {
        hasCalendarPermission = true;
      } else {}
    }
    AppLogger().info(message: "Calendar perm: $hasCalendarPermission");
    return Future<bool>.value(hasCalendarPermission);
  }

  Future<bool> permissionCam() async {
    bool hasCameraPermission = false;
    final PermissionStatus try0 = await Permission.camera.status;
    if (try0 == PermissionStatus.granted) {
      hasCameraPermission = true;
    } else {
      final PermissionStatus try1 = await Permission.camera.request();
      if (try1 == PermissionStatus.granted) {
        hasCameraPermission = true;
      } else {}
    }
    AppLogger().info(message: "Camera perm: $hasCameraPermission");
    return Future<bool>.value(hasCameraPermission);
  }

  Future<bool> permissionMic() async {
    bool hasMicrophonePermission = false;
    final PermissionStatus try0 = await Permission.microphone.status;
    if (try0 == PermissionStatus.granted) {
      hasMicrophonePermission = true;
    } else {
      final PermissionStatus try1 = await Permission.microphone.request();
      if (try1 == PermissionStatus.granted) {
        hasMicrophonePermission = true;
      } else {}
    }
    AppLogger().info(message: "Microphone perm: $hasMicrophonePermission");
    return Future<bool>.value(hasMicrophonePermission);
  }

  Future<bool> permissionPhotoOrStorage() async {
    bool perm = false;
    if (Platform.isIOS) {
      perm = await permissionPhotos();
    } else if (Platform.isAndroid) {
      try {
        final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
        perm = android.version.sdkInt <= 32
            ? await permissionStorage()
            : await permissionPhotos();
      } on Exception catch (error, stackTrace) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
      } finally {}
    } else {}
    AppLogger().info(message: "Photo Or Storage perm: $perm");
    return Future<bool>.value(perm);
  }
}
