// ignore_for_file: lines_longer_than_80_chars

// import "dart:async";
// import "dart:developer";
// import "dart:io";

// import "package:customer/services/app_api_service.dart";
// import "package:customer/services/app_firestore_user_db.dart";
// import "package:customer/services/app_perm_service.dart";
// import "package:customer/services/app_storage_service.dart";
// import "package:customer/utils/app_constants.dart";
// import "package:customer/utils/app_logger.dart";
// import "package:geolocator/geolocator.dart";
// import "package:get/get.dart";
// import "package:location/location.dart" as loc;
// import "package:permission_handler/permission_handler.dart";

// class AppLocationService extends GetxService {
//   factory AppLocationService() {
//     return _singleton;
//   }

//   AppLocationService._internal();
//   static final AppLocationService _singleton = AppLocationService._internal();

//   bool hasAlreadyAskedForGPSWitPrompt = true;
//   late Timer _timer;
//   (double, double, String) previousLocation = (0.0, 0.0, "");

//   @override
//   void onInit() {
//     super.onInit();

//     _timer = Timer.periodic(
//       AppConstants().locationFetchDuration,
//       (Timer timer) async {
//         await automatedFunction();
//       },
//     );
//   }

//   @override
//   void onClose() {
//     _timer.cancel();

//     super.onClose();
//   }

//   Future<void> checkAndEnableBackgrounsLocation() async {
//     try {
//       final PermissionStatus status1 = await Permission.location.status;
//       final PermissionStatus status2 = await Permission.locationAlways.status;

//       final bool cond1 = status1 == PermissionStatus.granted;
//       final bool cond2 = status2 == PermissionStatus.granted;
//       final bool cond3 = await loc.Location().serviceEnabled();
//       final bool cond4 = await loc.Location().isBackgroundModeEnabled();
//       final bool fCond = cond1 && cond2 && cond3 && !cond4;

//       final bool res = await loc.Location().enableBackgroundMode(enable: fCond);
//       AppLogger().info(message: "BackgrounsLocation(): res: $res");
//     } on Exception catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } finally {}
//     return Future<void>.value();
//   }

//   Future<void> automatedFunction() async {
//     await checkAndEnableBackgrounsLocation();

//     final (double, double, String) currentLocation = await decideAndSend();

//     if (previousLocation != currentLocation) {
//       final bool condition1 = !currentLocation.$1.isEqual(0.0);
//       final bool condition2 = !currentLocation.$2.isEqual(0.0);

//       if (condition1 && condition2) {
//         AppLogger().info(message: "automatedFunction(): Sync");

//         await updateInfoToBackend(
//           latitude: currentLocation.$1,
//           longitude: currentLocation.$2,
//           from: currentLocation.$3,
//         );

//         await updateInfoToFirestore(
//           latitude: currentLocation.$1,
//           longitude: currentLocation.$2,
//           from: currentLocation.$3,
//         );

//         previousLocation = currentLocation;
//       } else {
//         AppLogger().info(message: "automatedFunction(): Not sync: No Lat Long");
//       }
//     } else {
//       AppLogger().info(message: "automatedFunction(): Not sync: Same Location");
//     }
//     return Future<void>.value();
//   }

//   Future<(double, double, String)> decideAndSend() async {
//     double lat = 0.0;
//     double long = 0.0;
//     String from = "";

//     final (double, double) try0 = await fetchLocationFromGPS();
//     if ((!try0.$1.isEqual(0.0)) && (!try0.$2.isEqual(0.0))) {
//       lat = try0.$1;
//       long = try0.$2;
//       from = "GPS";
//     } else {
//       final (double, double) try1 = await fetchLocationFromIPAddress();
//       if ((!try1.$1.isEqual(0.0)) && (!try1.$2.isEqual(0.0))) {
//         lat = try1.$1;
//         long = try1.$2;
//         from = "IP";
//       } else {}
//     }

//     if ((!lat.isEqual(0.0)) && (!long.isEqual(0.0))) {
//       AppLogger().info(message: "decideAndSend: $from - lat: $lat long: $long");
//     } else {
//       AppLogger().error(message: "decideAndSend: Something went wrong");
//     }
//     return Future<(double, double, String)>.value((lat, long, from));
//   }

//   Future<(double, double)> fetchLocationFromGPS() async {
//     double lat = 0.0;
//     double long = 0.0;

//     if (!hasAlreadyAskedForGPSWitPrompt) {
//       hasAlreadyAskedForGPSWitPrompt = true;

//       final (double, double) data = await fetchLocationFromGPSWitPerm();
//       lat = data.$1;
//       long = data.$2;
//     } else {
//       final (double, double) data = await fetchLocationFromGPSWithoutPerm();
//       lat = data.$1;
//       long = data.$2;
//     }
//     return Future<(double, double)>.value((lat, long));
//   }

//   Future<(double, double)> fetchLocationFromGPSWitPerm() async {
//     double lat = 0.0;
//     double long = 0.0;

//     final bool hasPermission = await AppPermService().permissionLocation2();
//     final bool serviceEnable = await AppPermService().serviceLocation();

//     if (hasPermission && serviceEnable) {
//       final (double, double) data = await getLocation();
//       lat = data.$1;
//       long = data.$2;
//     } else {}
//     return Future<(double, double)>.value((lat, long));
//   }

//   Future<(double, double)> fetchLocationFromGPSWithoutPerm() async {
//     double lat = 0.0;
//     double long = 0.0;

//     final loc.PermissionStatus status = await loc.Location().hasPermission();
//     final bool isGranted = status == loc.PermissionStatus.granted;
//     final bool isGrantedLimited = status == loc.PermissionStatus.grantedLimited;
//     final bool hasPermission = isGranted || isGrantedLimited;
//     final bool serviceEnable = await loc.Location().serviceEnabled();

//     if (hasPermission && serviceEnable) {
//       final (double, double) data = await getLocation();
//       lat = data.$1;
//       long = data.$2;
//     } else {}
//     return Future<(double, double)>.value((lat, long));
//   }

//   Future<(double, double)> fetchLocationFromIPAddress() async {
//     const double lat = 0.0;
//     const double long = 0.0;
//     return Future<(double, double)>.value((lat, long));
//   }

//   Future<(double, double)> getLocation() async {
//     double lat = 0.0;
//     double long = 0.0;

//     try {
//       final Position data = await Geolocator.getCurrentPosition().timeout(
//         const Duration(minutes: 10),
//         onTimeout: () async {
//           final Position position = Position(
//             longitude: 0.0,
//             latitude: 0.0,
//             timestamp: DateTime.now(),
//             accuracy: 0.0,
//             altitude: 0.0,
//             altitudeAccuracy: 0.0,
//             heading: 0.0,
//             headingAccuracy: 0.0,
//             speed: 0.0,
//             speedAccuracy: 0.0,
//           );
//           return Future<Position>.value(position);
//         },
//       );

//       lat = data.latitude;
//       long = data.longitude;
//       AppLogger().info(message: "getLocation(): lat: $lat long: $long");
//     } on TimeoutException catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught: ${error.message}",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } on SocketException catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught: ${error.message}",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } on Exception catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } finally {}
//     return Future<(double, double)>.value((lat, long));
//   }

//   Future<void> updateInfoToBackend({
//     required double latitude,
//     required double longitude,
//     required String from,
//   }) async {
//     final bool canUpdate = AppConstants().isEnabledBackendUpdateLocInfo;
//     if (canUpdate) {
//       final String id = AppStorageService().getUserInfoModel().sId ?? "";
//       if (id.isEmpty) {
//       } else {
//         final Map<String, dynamic> data = <String, dynamic>{
//           "current_lattitude": latitude,
//           "current_longitude": longitude,
//         };

//         await AppAPIService().functionPatch(
//           types: Types.oauth,
//           endPoint: "user/0/coordinates",
//           body: data,
//           successCallback: (Map<String, dynamic> json) {
//             AppLogger().info(message: json["message"]);
//           },
//           failureCallback: (Map<String, dynamic> json) {
//             AppLogger().error(message: json["message"]);
//           },
//           needLoader: false,
//         );
//       }
//     } else {}
//     return Future<void>.value();
//   }

//   Future<void> updateInfoToFirestore({
//     required double latitude,
//     required double longitude,
//     required String from,
//   }) async {
//     final bool canUpdate = AppConstants().isEnabledFirestoreUpdateLocInfo;
//     if (canUpdate) {
//       final String id = AppStorageService().getUserInfoModel().sId ?? "";
//       if (id.isEmpty) {
//       } else {
//         final Map<String, dynamic> data = <String, dynamic>{
//           "location": <String, Object>{
//             "latitude": latitude,
//             "longitude": longitude,
//             "from": from,
//           },
//         };

//         await AppFirestoreUserDB().updateOrSetUser(
//           id: id,
//           data: data,
//           successCallback: log,
//           failureCallback: log,
//         );
//       }
//     } else {}
//     return Future<void>.value();
//   }
// }
