// ignore_for_file: lines_longer_than_80_chars

// import "dart:async";
// import "dart:convert";

// import "package:customer/utils/app_logger.dart";
// import "package:firebase_remote_config/firebase_remote_config.dart";
// import "package:get/get.dart";

// class AppRemoteConfig extends GetxService {
//   factory AppRemoteConfig() {
//     return _singleton;
//   }

//   AppRemoteConfig._internal();
//   static final AppRemoteConfig _singleton = AppRemoteConfig._internal();

//   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
//   late StreamSubscription<RemoteConfigUpdate> subscription;

//   final String paramBoolean = "param_boolean";
//   final String paramJson = "param_json";
//   final String paramNumber = "param_number";
//   final String paramString = "param_string";

//   Future<void> initFirebaseRemoteConfig() async {
//     try {
//       const Duration duration = Duration.zero;
//       final RemoteConfigSettings remoteConfigSettings = RemoteConfigSettings(
//         fetchTimeout: duration,
//         minimumFetchInterval: duration,
//       );

//       await remoteConfig.setConfigSettings(remoteConfigSettings);
//       await fetchAndActivate();
//     } on Exception catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } finally {}
//     return Future<void>.value();
//   }

//   Future<bool> fetchAndActivate() async {
//     bool activate = false;
//     try {
//       activate = await remoteConfig.fetchAndActivate();
//       AppLogger().info(message: "fetchAndActivate: $activate");
//     } on Exception catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } finally {}
//     return Future<bool>.value(activate);
//   }

//   @override
//   Future<void> onInit() async {
//     super.onInit();

//     await initFirebaseRemoteConfig();

//     subscription = remoteConfig.onConfigUpdated.listen(
//       (RemoteConfigUpdate event) async {
//         try {
//           await remoteConfig.activate();

//           if (event.updatedKeys.contains(paramBoolean)) {
//             final bool value = await getBool();
//             AppLogger().info(message: "$paramBoolean : $value");
//           } else {}

//           if (event.updatedKeys.contains(paramJson)) {
//             final Map<String, dynamic> value = await getJson();
//             AppLogger().info(message: "$paramJson : $value");
//           } else {}

//           if (event.updatedKeys.contains(paramNumber)) {
//             final double value = await getDouble();
//             AppLogger().info(message: "$paramNumber : $value");
//           } else {}

//           if (event.updatedKeys.contains(paramString)) {
//             final String value = await getString();
//             AppLogger().info(message: "$paramString : $value");
//           } else {}
//         } on Exception catch (error, stackTrace) {
//           AppLogger().error(
//             message: "Exception caught",
//             error: error,
//             stackTrace: stackTrace,
//           );
//         } finally {}
//       },
//       // ignore: always_specify_types
//       onError: (error, stackTrace) {
//         AppLogger().error(
//           message: "Exception caught",
//           error: error,
//           stackTrace: stackTrace,
//         );
//       },
//       cancelOnError: false,
//       onDone: () async {
//         AppLogger().info(message: "remoteConfig: subscription: onDone called");
//         await subscription.cancel();
//       },
//     );
//   }

//   @override
//   void onClose() {
//     unawaited(subscription.cancel());

//     super.onClose();
//   }

//   Future<bool> getBool() async {
//     final bool value = remoteConfig.getBool(paramBoolean);
//     return Future<bool>.value(value);
//   }

//   Future<Map<String, dynamic>> getJson() async {
//     final String value = remoteConfig.getString(paramJson);
//     return Future<Map<String, dynamic>>.value(jsonDecode(value));
//   }

//   Future<double> getDouble() async {
//     final double value = remoteConfig.getDouble(paramNumber);
//     return Future<double>.value(value);
//   }

//   Future<String> getString() async {
//     final String value = remoteConfig.getString(paramString);
//     return Future<String>.value(value);
//   }
// }
