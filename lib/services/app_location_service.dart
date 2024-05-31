import "dart:async";
import "dart:developer";

import "package:customer/models/vpn_api_custom.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_firestore_user_db.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_logger.dart";
import "package:dart_ipify/dart_ipify.dart";
import "package:geolocator/geolocator.dart";
import "package:get/get.dart";
import "package:location/location.dart" as loc;

class AppLocationService extends GetxService {
  factory AppLocationService() {
    return _singleton;
  }

  AppLocationService._internal();
  static final AppLocationService _singleton = AppLocationService._internal();

  bool hasAlreadyAskedForGPSWitPrompt = false;
  // late Timer _timer;
  (double, double, String) previousLocation = (0.0, 0.0, "");

  // @override
  // void onInit() {
  //   super.onInit();

  //   _timer = Timer.periodic(
  //     AppConstants().locationFetchDuration,
  //     (Timer timer) async {
  //       await automatedFunction();
  //     },
  //   );
  // }

  // @override
  // void onClose() {
  //   _timer.cancel();

  //   super.onClose();
  // }

  Future<void> automatedFunction() async {
    final (double, double, String) currentLocation = await decideAndSend();
    AppLogger().info(message: "automatedFunction(): curr.: $currentLocation");
    AppLogger().info(message: "automatedFunction(): prev.: $previousLocation");

    if (previousLocation != currentLocation) {
      final bool condition1 = !currentLocation.$1.isEqual(0.0);
      final bool condition2 = !currentLocation.$2.isEqual(0.0);

      if (condition1 && condition2) {
        AppLogger().info(message: "automatedFunction(): Sync");
        await updateInfoToFirestore(
          latitude: currentLocation.$1,
          longitude: currentLocation.$2,
          from: currentLocation.$3,
        );

        previousLocation = currentLocation;
      } else {
        AppLogger().info(message: "automatedFunction(): Not sync: No Lat Long");
      }
    } else {
      AppLogger().info(message: "automatedFunction(): Not sync: Same Location");
    }
    return Future<void>.value();
  }

  Future<(double, double, String)> decideAndSend() async {
    double lat = 0.0;
    double long = 0.0;
    String from = "";

    final (double, double) try0 = await fetchLocationFromGPS();
    if ((!try0.$1.isEqual(0.0)) && (!try0.$2.isEqual(0.0))) {
      lat = try0.$1;
      long = try0.$2;
      from = "GPS";
    } else {
      final (double, double) try1 = await fetchLocationFromIPAddress();
      if ((!try1.$1.isEqual(0.0)) && (!try1.$2.isEqual(0.0))) {
        lat = try1.$1;
        long = try1.$2;
        from = "IP";
      } else {}
    }

    if ((!lat.isEqual(0.0)) && (!long.isEqual(0.0))) {
      AppLogger().info(message: "decideAndSend: $from - lat: $lat long: $long");
    } else {
      AppLogger().error(message: "decideAndSend: Something went wrong");
    }
    return Future<(double, double, String)>.value((lat, long, from));
  }

  Future<(double, double)> fetchLocationFromGPS() async {
    double lat = 0.0;
    double long = 0.0;

    if (!hasAlreadyAskedForGPSWitPrompt) {
      hasAlreadyAskedForGPSWitPrompt = true;

      final (double, double) data = await fetchLocationFromGPSWitPerm();
      lat = data.$1;
      long = data.$2;
    } else {
      final (double, double) data = await fetchLocationFromGPSWithoutPerm();
      lat = data.$1;
      long = data.$2;
    }
    return Future<(double, double)>.value((lat, long));
  }

  Future<(double, double)> fetchLocationFromGPSWitPerm() async {
    double lat = 0.0;
    double long = 0.0;

    final bool hasPermission = await AppPermService().permissionLocation();
    final bool serviceEnable = await AppPermService().serviceLocation();

    if (hasPermission && serviceEnable) {
      final Position data = await Geolocator.getCurrentPosition();
      lat = data.latitude;
      long = data.longitude;
      AppLogger().info(message: "GPSWithPerm: lat: $lat long: $long");
    } else {}
    return Future<(double, double)>.value((lat, long));
  }

  Future<(double, double)> fetchLocationFromGPSWithoutPerm() async {
    double lat = 0.0;
    double long = 0.0;

    final loc.PermissionStatus status = await loc.Location().hasPermission();
    final bool isGranted = status == loc.PermissionStatus.granted;
    final bool isGrantedLimited = status == loc.PermissionStatus.grantedLimited;

    final bool hasPermission = isGranted || isGrantedLimited;
    final bool serviceEnable = await loc.Location().serviceEnabled();

    if (hasPermission && serviceEnable) {
      try {
        final Position data = await Geolocator.getCurrentPosition();
        lat = data.latitude;
        long = data.longitude;
        AppLogger().info(message: "GPSWithoutPerm: lat: $lat long: $long");
      } on Exception catch (error, stackTrace) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
      } finally {}
    } else {}
    return Future<(double, double)>.value((lat, long));
  }

  Future<(double, double)> fetchLocationFromIPAddress() async {
    final Completer<(double, double)> completer = Completer<(double, double)>();

    final String ip = await Ipify.ipv64();
    AppLogger().info(message: "fetchLocationFromIPAddress(): ip: $ip");

    if (ip.isEmpty) {
      completer.complete((0.0, 0.0));
    } else {
      await AppAPIService().functionGet(
        types: Types.oauth,
        endPoint: "vpn-info",
        body: <String, dynamic>{"ip": ip},
        successCallback: (Map<String, dynamic> json) {
          AppLogger().info(message: json["message"]);

          VPNAPICustom model = VPNAPICustom();
          model = VPNAPICustom.fromJson(json);

          final String strLatitude = model.data?.latitude ?? "0.0";
          final String strLongitude = model.data?.longitude ?? "0.0";
          final double lat = double.tryParse(strLatitude) ?? 0.0;
          final double long = double.tryParse(strLongitude) ?? 0.0;

          completer.complete((lat, long));
        },
        failureCallback: (Map<String, dynamic> json) {
          AppLogger().error(message: json["message"]);

          completer.complete((0.0, 0.0));
        },
        needLoader: false,
      );
    }

    return completer.future;
  }

  Future<void> updateInfoToFirestore({
    required double latitude,
    required double longitude,
    required String from,
  }) async {
    final bool canUpdate = AppConstants().isEnabledFirestoreUpdateLocInfo;
    if (canUpdate) {
      final String id = AppStorageService().getUserInfoModel().sId ?? "";
      if (id.isEmpty) {
      } else {
        final Map<String, dynamic> data = <String, dynamic>{
          "location": <String, Object>{
            "latitude": latitude,
            "longitude": longitude,
            "from": from,
          },
        };

        await AppFirestoreUserDB().updateOrSetUser(
          id: id,
          data: data,
          successCallback: log,
          failureCallback: log,
        );
      }
    } else {}
    return Future<void>.value();
  }
}
