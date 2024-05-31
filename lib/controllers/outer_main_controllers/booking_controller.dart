import "dart:async";

import "package:customer/models/create_booking.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_all_services.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:place_picker/entities/location_result.dart";

class BookingController extends GetxController {
  final SearchController searchController = SearchController();
  final RxString rxSearchQuery = "".obs;

  final RxList<Address> rxAddressList = <Address>[].obs;

  final TextEditingController cropNameController = TextEditingController();
  final RxString rxCropName = "".obs;

  final TextEditingController startTimeController = TextEditingController();
  final RxString rxStartTime = "".obs;

  final TextEditingController endTimeController = TextEditingController();
  final RxString rxEndTime = "".obs;

  final TextEditingController dateController = TextEditingController();
  final RxString rxDate = "".obs;

  final RxList<Categories> categoriesList = <Categories>[].obs;
  final Rx<Categories> rxSelectedCategory = Categories().obs;

  final RxList<Services> servicesList = <Services>[].obs;
  final Rx<Services> rxSelectedService = Services().obs;

  final RxDouble rxFarmArea = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    unawaited(getAddressesAPI());
    unawaited(getCategoriesAPI());
  }

  void updateQuery(String value) {
    rxSearchQuery(value);
    return;
  }

  Future<void> getAddressesAPI() async {
    await AppAPIService().functionGet(
      types: Types.oauth,
      endPoint: "address",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAddresses model = GetAddresses();
        model = GetAddresses.fromJson(json);

        rxAddressList
          ..clear()
          ..addAll(model.data?.address ?? <Address>[])
          ..refresh();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: false,
    );
    return Future<void>.value();
  }

  String validateLocationResult({required LocationResult result}) {
    String reason = "";

    final bool cond1 = (result.postalCode ?? "").isNotEmpty;
    final bool cond2 = (result.formattedAddress ?? "").isNotEmpty;
    final bool cond3 = (result.city?.name ?? "").isNotEmpty;
    final bool cond4 = (result.country?.name ?? "").isNotEmpty;
    final bool cond5 = (result.latLng?.latitude ?? 0.0) != 0.0;
    final bool cond6 = (result.latLng?.longitude ?? 0.0) != 0.0;

    if (!cond1) {
      reason = "postalCode is missing, please select nearby location.";
    } else if (!cond2) {
      reason = "formattedAddress is missing, please select nearby location.";
    } else if (!cond3) {
      reason = "city name is missing, please select nearby location.";
    } else if (!cond4) {
      reason = "country name is missing, please select nearby location.";
    } else if (!cond5) {
      reason = "latitude is missing, please select nearby location.";
    } else if (!cond6) {
      reason = "longitude is missing, please select nearby location.";
    } else {}
    return reason;
  }

  Future<void> setAddressesAPI({required LocationResult result}) async {
    await AppAPIService().functionPost(
      types: Types.oauth,
      endPoint: "address",
      body: <String, dynamic>{
        "pinCode": result.postalCode ?? "",
        "street": result.formattedAddress ?? "",
        "city": result.city?.name ?? "",
        "country": result.country?.name ?? "",
        "latitude": result.latLng?.latitude ?? "",
        "longitude": result.latLng?.longitude ?? "",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        unawaited(getAddressesAPI());
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );
    return Future<void>.value();
  }

  Future<void> getCategoriesAPI() async {
    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "vehicleCategories",
      query: <String, dynamic>{
        "page": 1,
        "limit": 1000,
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        FeaturedModel model = FeaturedModel();
        model = FeaturedModel.fromJson(json);

        categoriesList
          ..clear()
          ..addAll(model.data?.categories ?? <Categories>[])
          ..refresh();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: false,
    );
    return Future<void>.value();
  }

  Future<void> getServicesAPI() async {
    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "services",
      query: <String, dynamic>{
        "page": 1,
        "limit": 1000,
        "categoryId": categoriesList[getSelectedCategoryIndex()].sId ?? "",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAllServices model = GetAllServices();
        model = GetAllServices.fromJson(json);

        servicesList
          ..clear()
          ..addAll(model.data?.services ?? <Services>[])
          ..refresh();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: false,
    );
    return Future<void>.value();
  }

  Future<CreateBookingData> createBookingAPI() async {
    final Completer<CreateBookingData> completer =
        Completer<CreateBookingData>();

    final Map<String, dynamic> body = <String, dynamic>{
      "scheduleDate": rxDate.value,
      "approxStartTime": rxStartTime.value,
      "approxEndTime": rxEndTime.value,
      "crop": rxCropName.value,
      "vehicleCategory": categoriesList[getSelectedCategoryIndex()].sId ?? "",
      "deliveryAddress": rxAddressList[getSelectedAddressIndex()].sId ?? "",
      "services": <Map<String, dynamic>>[
        <String, dynamic>{
          "service": servicesList[getSelectedServiceIndex()].sId ?? "",
          "area": rxFarmArea.value,
        }
      ],
    };

    await AppAPIService().functionPost(
      types: Types.rental,
      endPoint: "booking",
      body: body,
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        CreateBooking model = CreateBooking();
        model = CreateBooking.fromJson(json);

        completer.complete(model.data ?? CreateBookingData());
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(CreateBookingData());
      },
    );
    return completer.future;
  }

  Future<bool> confirmOrderAPICall({required String id}) async {
    final Completer<bool> completer = Completer<bool>();
    await AppAPIService().functionPatch(
      types: Types.rental,
      endPoint: "accept/booking/$id",
      body: <String, String>{"status": "BookingConfirm"},
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }

  void clearForm() {
    searchController.clear();
    rxSearchQuery("");

    cropNameController.clear();
    rxCropName("");

    startTimeController.clear();
    rxStartTime("");

    endTimeController.clear();
    rxEndTime("");

    dateController.clear();
    rxDate("");

    rxSelectedCategory(Categories());
    rxSelectedService(Services());

    rxFarmArea(0.0);

    return;
  }

  String validateForm() {
    String reason = "";

    final bool cond01 = searchController.value.text.isNotEmpty;
    final bool cond02 = getSelectedAddressIndex() != -1;
    final bool cond03 = cropNameController.value.text.isNotEmpty;
    final bool cond04 = rxCropName.value.isNotEmpty;
    final bool cond05 = startTimeController.value.text.isNotEmpty;
    final bool cond06 = rxStartTime.value.isNotEmpty;
    final bool cond07 = endTimeController.value.text.isNotEmpty;
    final bool cond08 = rxEndTime.value.isNotEmpty;
    final bool cond9 = dateController.value.text.isNotEmpty;
    final bool cond10 = rxDate.value.isNotEmpty;

    final bool cond11 = !mapEquals(
      rxSelectedCategory.value.toJson(),
      Categories().toJson(),
    );
    final bool cond12 = getSelectedCategoryIndex() != -1;
    final bool cond13 = !mapEquals(
      rxSelectedService.value.toJson(),
      GetAllServicesData().toJson(),
    );
    final bool cond14 = getSelectedServiceIndex() != -1;
    final bool cond15 = rxFarmArea.value > 0.0;
    final bool cond16 = isValidStartAndEndTime();

    if (!cond01) {
      reason = "Please select your location.";
    } else if (!cond02) {
      reason = "Please select your location from saved addresses.";
    } else if (!cond03) {
      reason = "Please enter your crop name.";
    } else if (!cond04) {
      reason = "Please enter your valid crop name.";
    } else if (!cond05) {
      reason = "Please enter your start time.";
    } else if (!cond06) {
      reason = "Please enter your valid start time.";
    } else if (!cond07) {
      reason = "Please enter your end time.";
    } else if (!cond08) {
      reason = "Please enter your valid end time.";
    } else if (!cond9) {
      reason = "Please enter your date.";
    } else if (!cond10) {
      reason = "Please enter your valid date.";
    } else if (!cond11) {
      reason = "Please select any category.";
    } else if (!cond12) {
      reason = "Please select any category.";
    } else if (!cond13) {
      reason = "Please select any service.";
    } else if (!cond14) {
      reason = "Please select any service.";
    } else if (!cond15) {
      reason = "Please select any farm area greater than 0.";
    } else if (!cond16) {
      reason = "Start time should be greater than end time - 1 hour difference";
    } else {}
    return reason;
  }

  List<Address> getSuggestions() {
    final String query = rxSearchQuery.value;

    return query.isEmpty
        ? rxAddressList
        : rxAddressList.where(
            (Address item) {
              final String streetLowerCase = (item.street ?? "").toLowerCase();
              final String queryLowerCase = query.toLowerCase();
              return streetLowerCase.contains(queryLowerCase);
            },
          ).toList();
  }

  int getSelectedAddressIndex() {
    return rxAddressList.indexWhere(
      (Address item) => (item.street ?? "") == searchController.value.text,
    );
  }

  int getSelectedCategoryIndex() {
    return categoriesList.indexWhere(
      (Categories item) => item == rxSelectedCategory.value,
    );
  }

  int getSelectedServiceIndex() {
    return servicesList.indexWhere(
      (Services item) => item == rxSelectedService.value,
    );
  }

  bool isValidStartAndEndTime() {
    final DateTime startTime = DateTime.parse(rxStartTime.value);
    final DateTime endTime = DateTime.parse(rxEndTime.value);
    return endTime.isAfter(startTime) &&
        endTime.difference(startTime) >= const Duration(hours: 1);
  }
}
