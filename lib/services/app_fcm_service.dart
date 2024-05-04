import "dart:developer";

import "package:customer/models/fcm_data.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_routes.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:get/get.dart";
import "package:overlay_support/overlay_support.dart";

class AppFCMService extends GetxService {
  factory AppFCMService() {
    return _singleton;
  }

  AppFCMService._internal();
  static final AppFCMService _singleton = AppFCMService._internal();

  final FirebaseMessaging instance = FirebaseMessaging.instance;

  String route = "";
  int arguments = 0;

  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        await onTapForegoundOrBackground(message.data.toString());
      },
    );
    await enableIOSNotifications();
    await registerNotificationListeners();
    return Future<void>.value();
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    return Future<void>.value();
  }

  Future<void> registerNotificationListeners() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      description: "This channel is used for important notifications.",
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin plugin =
        FlutterLocalNotificationsPlugin();
    await AppPermService().permissionNotification();
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings();
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );
    await plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        await onTapForegoundOrBackground(details.payload ?? "");
      },
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) async {
        final RemoteNotification? notification = message!.notification;
        final AndroidNotification? android = message.notification?.android;
        final AppleNotification? apple = message.notification?.apple;

        if (notification != null && (android != null || apple != null)) {
          OverlaySupportEntry overlaySupportEntry = OverlaySupportEntry.empty();
          overlaySupportEntry = showSimpleNotification(
            const SizedBox(),
            context: Get.context,
            elevation: AppConstants().elevation,
            foreground: Theme.of(Get.context!).scaffoldBackgroundColor,
            background: Theme.of(Get.context!).colorScheme.primary,
            subtitle: ListTile(
              dense: true,
              title: Text(
                notification.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                notification.body ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () async {
                overlaySupportEntry.dismiss();
                final Map<String, dynamic> payload = message.data;
                final String stringPayload = payload.toString();
                await onTapForegoundOrBackground(stringPayload);
              },
            ),
            duration: const Duration(seconds: 5),
            slideDismissDirection: DismissDirection.horizontal,
          );

          // if (hasLoggedIn) {
          //   await BadgeCountService.instance.makeAPIRequestGetBadgeCount(
          //     onSuccess: (String message) async {},
          //     onfailure: (String message) async {},
          //   );
          // } else {}
        } else {}
      },
    );
    return Future<void>.value();
  }

  Future<void> onTapForegoundOrBackground(String payload) async {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap = jsonStringToMap(payload)
      ..update(
        "_id",
        // ignore: avoid_annotating_with_dynamic
        (dynamic value) {
          final dynamic temp = value;
          return int.parse(temp);
        },
      );
    FCMData notificationData = FCMData();
    notificationData = FCMData.fromJson(jsonMap);
    String route = "";
    final int arguments = notificationData.id ?? 0;
    switch (notificationData.screen) {
      case "Home":
        route = AppRoutes().mainNavigationScreen;
        break;

      default:
        break;
    }
    route.isEmpty
        ? log("route isEmpty")
        : route == AppRoutes().mainNavigationScreen
            ? await Get.offAllNamed(AppRoutes().mainNavigationScreen)
            : await Get.toNamed(
                route,
                arguments: arguments,
                preventDuplicates: false,
              );
    return Future<void>.value();
  }

  Future<void> onTapTerminated(String payload) async {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap = jsonStringToMap(payload)
      ..update(
        "_id",
        // ignore: avoid_annotating_with_dynamic
        (dynamic value) {
          final dynamic temp = value;
          return int.parse(temp);
        },
      );
    FCMData notificationData = FCMData();
    notificationData = FCMData.fromJson(jsonMap);
    switch (notificationData.screen) {
      case "Home":
        route = AppRoutes().mainNavigationScreen;
        break;

      default:
        break;
    }
    arguments = notificationData.id ?? 0;
    return Future<void>.value();
  }

  Map<String, dynamic> jsonStringToMap(String data) {
    final List<String> str = data
        .replaceAll("{", "")
        .replaceAll("}", "")
        // ignore: avoid_escaping_inner_quotes
        .replaceAll("\"", "")
        .replaceAll("'", "")
        .split(",");
    final Map<String, dynamic> result = <String, dynamic>{};
    for (int i = 0; i < str.length; i++) {
      final List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }
}
