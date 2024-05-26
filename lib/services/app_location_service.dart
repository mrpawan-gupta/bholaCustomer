import "dart:async";
import "dart:developer";

import "package:customer/services/app_firestore_user_db.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_logger.dart";
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
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();

    _timer = Timer.periodic(
      AppConstants().locationFetchDuration,
      (Timer timer) async {
        await automatedFunction();
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();

    super.onClose();
  }

  Future<void> automatedFunction() async {
    final (double, double, String) value = await decideAndSend();

    if ((!value.$1.isEqual(0.0)) && (!value.$2.isEqual(0.0))) {
      await updateInfoToFirestore(
        latitude: value.$1,
        longitude: value.$2,
        from: value.$3,
      );
    } else {}
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
    double lat = 0.0;
    double long = 0.0;

    // await AppAPIService().functionGet(
    //   endPoint: "",
    //   query: <String, dynamic>{"key": AppConstants().vpnAPIKey},
    //   body: <String, dynamic>{},
    //   successCallback: (Map<String, dynamic> json) {
    //     final VPNAPIIOResponse response = VPNAPIIOResponse.fromJson(json);
    //     final String strLatitude = response.location?.latitude ?? "0.0";
    //     final String strLongitude = response.location?.longitude ?? "0.0";
    //     lat = double.tryParse(strLatitude) ?? 0.0;
    //     long = double.tryParse(strLongitude) ?? 0.0;
    //     AppLogger().info(message: "LocationFromIP: lat: $lat long: $long");
    //   },
    //   failureCallback: (Map<String, dynamic> json) {},
    // );

    lat = 22.4667;
    long = 70.0644;
    AppLogger().info(message: "FromIP: lat: $lat long: $long");

    return Future<(double, double)>.value((lat, long));
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
