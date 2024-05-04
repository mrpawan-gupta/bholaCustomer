import "dart:developer";

import "package:customer/models/vpn_api_io_response.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:geolocator/geolocator.dart";
import "package:get/get.dart";

class AppLocationService extends GetxService {
  factory AppLocationService() {
    return _singleton;
  }

  AppLocationService._internal();
  static final AppLocationService _singleton = AppLocationService._internal();

  Future<void> fetchLocationFromGPS() async {
    final bool hasPermission = await AppPermService().permissionLocation();
    if (hasPermission) {
      final bool serviceEnabled = await AppPermService().serviceLocation();
      if (serviceEnabled) {
        final Position data = await Geolocator.getCurrentPosition();
        final double latitude = data.latitude;
        final double longitude = data.longitude;
        log("LocationFromGPS: latitude: $latitude longitude: $longitude");
      } else {}
    } else {}
    return Future<void>.value();
  }

  Future<void> fetchLocationFromIPAddress() async {
    await AppAPIService().functionGet(
      endPoint: "",
      query: <String, dynamic>{"key": AppConstants().vpnAPIKey},
      body: <String, dynamic>{},
      successCallback: (Map<String, dynamic> json) {
        final VPNAPIIOResponse response = VPNAPIIOResponse.fromJson(json);
        final String strLatitude = response.location?.latitude ?? "0.0";
        final String strLongitude = response.location?.longitude ?? "0.0";
        final double latitude = double.tryParse(strLatitude) ?? 0.0;
        final double longitude = double.tryParse(strLongitude) ?? 0.0;
        log("LocationFromIP: latitude: $latitude longitude: $longitude");
      },
      failureCallback: (Map<String, dynamic> json) {},
    );
    return Future<void>.value();
  }
}
