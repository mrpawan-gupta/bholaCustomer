import "dart:developer";

import "package:customer/models/fcm_data.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_pretty_print_json.dart";
import "package:customer/utils/app_routes.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:get/get.dart";

class AppFCMService extends GetxService {
  factory AppFCMService() {
    return _singleton;
  }

  AppFCMService._internal();
  static final AppFCMService _singleton = AppFCMService._internal();

  final FirebaseMessaging instance = FirebaseMessaging.instance;

  String route = "";
  String arguments = "";

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

        final bool condition1 = notification != null;
        final bool condition2 = android != null || apple != null;

        if (condition1 && condition2) {
          Get
            ..closeAllSnackbars()
            ..snackbar(
              notification.title ?? "",
              notification.body ?? "",
              snackPosition: SnackPosition.TOP,
              backgroundColor: AppColors().appPrimaryColor.withOpacity(0.64),
              duration: const Duration(seconds: 4),
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              colorText: Colors.white,
              onTap: (GetSnackBar getSnackBar) async {
                final Map<String, dynamic> payload = message.data;
                final String stringPayload = payload.toString();
                await onTapForegoundOrBackground(stringPayload);
              },
            );
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
          return temp;
        },
      );
    FCMData notificationData = FCMData();
    notificationData = FCMData.fromJson(jsonMap);
    String route = "";
    final String id = notificationData.id ?? "";
    switch (notificationData.screen) {
      case "Home":
        route = AppRoutes().mainNavigationScreen;
        break;
      case "bookingDetailsScreen":
        route = AppRoutes().bookingDetailsScreen;
        break;
      default:
        break;
    }
    route.isEmpty
        ? log("route isEmpty")
        : route == AppRoutes().mainNavigationScreen
            ? await AppNavService().pushNamed(
                destination: AppRoutes().mainNavigationScreen,
                arguments: <String, dynamic>{},
              )
            : await AppNavService().pushNamed(
                destination: route,
                arguments: <String, dynamic>{"id": id},
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
          return temp;
        },
      );
    FCMData notificationData = FCMData();
    notificationData = FCMData.fromJson(jsonMap);
    switch (notificationData.screen) {
      case "Home":
        route = AppRoutes().mainNavigationScreen;
        break;
      case "bookingDetailsScreen":
        route = AppRoutes().bookingDetailsScreen;
        break;
      default:
        break;
    }
    arguments = notificationData.id ?? "";
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

  Future<void> getToken() async {
    try {
      final String fcmToken = await instance.getToken() ?? "";
      AppLogger().info(message: "fcmToken: $fcmToken");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return Future<void>.value();
  }

  Future<void> getInitialMessage() async {
    try {
      RemoteMessage? initialMessage;
      initialMessage = await AppFCMService().instance.getInitialMessage();

      if (initialMessage != null) {
        final Map<String, dynamic> mapData = initialMessage.data;
        final String prettyJSON = AppPrettyPrintJSON().prettyPrint(mapData);
        log("getInitialMessage(): prettyJSON: $prettyJSON");

        final String stringData = initialMessage.data.toString();
        await AppFCMService().onTapTerminated(stringData);
      } else {}
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return Future<void>.value();
  }

  Future<void> subscribeToTopic({required String id}) async {
    if (id.isNotEmpty) {
      try {
        final bool value = isValidTopic(id);
        value
            ? await instance.subscribeToTopic(id)
            : AppLogger().error(message: "$id must match the firebase regex.");
      } on Exception catch (error, stackTrace) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
      } finally {}
    } else {}
    return Future<void>.value();
  }

  Future<void> unsubscribeFromTopic({required String id}) async {
    if (id.isNotEmpty) {
      try {
        final bool value = isValidTopic(id);
        value
            ? await instance.unsubscribeFromTopic(id)
            : AppLogger().error(message: "$id must match the firebase regex.");
      } on Exception catch (error, stackTrace) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
      } finally {}
    } else {}
    return Future<void>.value();
  }

  bool isValidTopic(String topic) {
    final bool isValid = RegExp(r"^[a-zA-Z0-9-_.~%]{1,900}$").hasMatch(topic);
    return isValid;
  }
}
