import "dart:async";

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/common_functions/rental_booking_stream.dart";
import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/models/create_booking.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_all_crops_model.dart";
import "package:customer/models/get_all_services.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:location/location.dart" as loc;
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

  final Rx<Crops> rxSelectedCrop = Crops().obs;
  final RxBool rxNeedToShowAreaWidget = false.obs;
  final RxBool rxNeedToShowHourWidget = false.obs;

  @override
  void onInit() {
    super.onInit();

    unawaited(getAddressesAPI());
    unawaited(getCategoriesAPI());

    RentalBookingStream().subscribe(
      callback: (String newId) async {
        final String selectedId = rxSelectedCategory.value.sId ?? "";

        if (selectedId.isNotEmpty) {
          if (selectedId != newId) {
            final String oldName = getCategoryById(id: selectedId).name ?? "";
            final String newName = getCategoryById(id: newId).name ?? "";

            await openConfirmUpdateRentalCategoryWidget(
              oldName: oldName,
              newName: newName,
              onPressedUpdate: () async {
                await clearAndUpdateForm(id: newId);
              },
            );
          } else {}
        } else {
          await clearAndUpdateForm(id: newId);
        }
      },
    );
  }

  Future<void> clearAndUpdateForm({required String id}) async {
    clearForm();

    await updateFormFurther(getCategoryById(id: id));

    return Future<void>.value();
  }

  Future<void> updateFormFurther(Categories value) async {
    final Map<String, dynamic> map1 = value.toJson();
    final Map<String, dynamic> map2 = Categories().toJson();
    final bool isMapEquals = mapEquals(map1, map2);

    if (!isMapEquals) {
      rxSelectedCategory(value);
      setupUIProcedure();

      rxSelectedService(Services());
      servicesList.clear();

      await getServicesAPI();
    } else {}

    return Future<void>.value();
  }

  Categories getCategoryById({required String id}) {
    return categoriesList.firstWhere(
      (Categories e) => (e.sId ?? "") == id,
      orElse: Categories.new,
    );
  }

  void updateQuery(String value) {
    rxSearchQuery(value);
    return;
  }

  Future<void> getAddressesAPI() async {
    await AppAPIService().functionGet(
      types: Types.oauth,
      endPoint: "address/0",
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
      endPoint: "vehiclecategory",
      query: <String, dynamic>{
        "page": 1,
        "limit": 1000,
        "status": "Approved",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        FeaturedModel model = FeaturedModel();
        model = FeaturedModel.fromJson(json);

        rxSelectedCategory(Categories());
        categoriesList
          ..clear()
          ..addAll(model.data?.categories ?? <Categories>[])
          ..refresh();

        setupUIProcedure();
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
      endPoint: "service",
      query: <String, dynamic>{
        "page": 1,
        "limit": 1000,
        "categoryId": categoriesList[getSelectedCategoryIndex()].sId ?? "",
        "status": "Approved",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAllServices model = GetAllServices();
        model = GetAllServices.fromJson(json);

        rxSelectedService(Services());
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
      "vehicleCategory": categoriesList[getSelectedCategoryIndex()].sId ?? "",
      "deliveryAddress": rxAddressList[getSelectedAddressIndex()].sId ?? "",
      "type": rxSelectedCategory.value.displayType ?? "",
      "services": <Map<String, dynamic>>[
        <String, dynamic>{
          "service": servicesList[getSelectedServiceIndex()].sId ?? "",
          "area": rxNeedToShowAreaWidget.value ? rxFarmArea.value : 0.0,
        }
      ],
    };

    if (rxCropName.value.isNotEmpty) {
      body.addAll(<String, dynamic>{"crop": rxSelectedCrop.value.sId ?? ""});
    } else {}

    if (rxNeedToShowHourWidget.value) {
      body.addAll(
        <String, dynamic>{
          "approxStartTime": rxStartTime.value,
          "approxEndTime": rxEndTime.value,
          "hours": timeDiff(),
        },
      );
    } else {}

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
      endPoint: "booking/$id/status",
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

    rxSelectedCategory(Categories());
    rxSelectedService(Services());

    rxSelectedCrop(Crops());
    cropNameController.clear();
    rxCropName("");

    dateController.clear();
    rxDate("");

    startTimeController.clear();
    rxStartTime("");

    endTimeController.clear();
    rxEndTime("");

    rxFarmArea(0.0);

    rxNeedToShowAreaWidget(false);
    rxNeedToShowHourWidget(false);

    return;
  }

  String validateForm() {
    String reason = "";

    final bool cond01 = searchController.value.text.isNotEmpty;
    final bool cond02 = getSelectedAddressIndex() != -1;

    final Map<String, dynamic> tempCatMap1 = rxSelectedCategory.value.toJson();
    final Map<String, dynamic> tempCatMap2 = Categories().toJson();
    final bool cond03 = !mapEquals(tempCatMap1, tempCatMap2);
    final bool cond04 = getSelectedCategoryIndex() != -1;

    final Map<String, dynamic> tempSerMap1 = rxSelectedService.value.toJson();
    final Map<String, dynamic> tempSerMap2 = GetAllServicesData().toJson();
    final bool cond05 = !mapEquals(tempSerMap1, tempSerMap2);
    final bool cond06 = getSelectedServiceIndex() != -1;

    final String temp = cropNameController.value.text;
    final bool cond07 = !rxNeedToShowAreaWidget.value || temp.isNotEmpty;
    final bool cond08 = !rxNeedToShowAreaWidget.value || temp.isNotEmpty;

    final bool cond9 = dateController.value.text.isNotEmpty;
    final bool cond10 = rxDate.value.isNotEmpty;

    final String startTime1 = startTimeController.value.text;
    final bool cond11 = !rxNeedToShowHourWidget.value || startTime1.isNotEmpty;

    final String startTime2 = rxStartTime.value;
    final bool cond12 = !rxNeedToShowHourWidget.value || startTime2.isNotEmpty;

    final String endTime1 = endTimeController.value.text;
    final bool cond13 = !rxNeedToShowHourWidget.value || endTime1.isNotEmpty;

    final String endTime2 = rxEndTime.value;
    final bool cond14 = !rxNeedToShowHourWidget.value || endTime2.isNotEmpty;

    final bool cond15 = isValidStartAndEndTime();
    final bool cond16 = !rxNeedToShowAreaWidget.value || rxFarmArea.value > 0.0;

    if (!cond01) {
      reason = "Please select your location.";
    } else if (!cond02) {
      reason = "Please select your location from saved addresses.";
    } else if (!cond03) {
      reason = "Please select any category.";
    } else if (!cond04) {
      reason = "Please select any category.";
    } else if (!cond05) {
      reason = "Please select any service.";
    } else if (!cond06) {
      reason = "Please select any service.";
    } else if (!cond07) {
      reason = "Please enter your crop name.";
    } else if (!cond08) {
      reason = "Please enter your valid crop name.";
    } else if (!cond9) {
      reason = "Please enter your date.";
    } else if (!cond10) {
      reason = "Please enter your valid date.";
    } else if (!cond11) {
      reason = "Please enter your start time.";
    } else if (!cond12) {
      reason = "Please enter your valid start time.";
    } else if (!cond13) {
      reason = "Please enter your end time.";
    } else if (!cond14) {
      reason = "Please enter your valid end time.";
    } else if (!cond15) {
      reason = "Start time should be greater than end time - 1 hour difference";
    } else if (!cond16) {
      reason = "Please select any farm area greater than 0.";
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
      (Address item) {
        return (item.street ?? "") == searchController.value.text;
      },
    );
  }

  int getSelectedCategoryIndex() {
    return categoriesList.indexWhere(
      (Categories item) {
        return item == rxSelectedCategory.value;
      },
    );
  }

  int getSelectedServiceIndex() {
    return servicesList.indexWhere(
      (Services item) {
        return item == rxSelectedService.value;
      },
    );
  }

  bool isValidStartAndEndTime() {
    if (rxStartTime.value.isEmpty || rxEndTime.value.isEmpty) {
      return false;
    } else {
      final DateTime? startTime = DateTime.tryParse(rxStartTime.value);
      final DateTime? endTime = DateTime.tryParse(rxEndTime.value);
      if (startTime != null && endTime != null) {
        const Duration diff = Duration(hours: 1);
        final bool cond1 = endTime.isAfter(startTime);
        final bool cond2 = endTime.difference(startTime) >= diff;
        return cond1 && cond2;
      } else {
        return false;
      }
    }
  }

  double timeDiff() {
    if (rxStartTime.value.isEmpty || rxEndTime.value.isEmpty) {
      return 0.0;
    } else {
      final DateTime? startTime = DateTime.tryParse(rxStartTime.value);
      final DateTime? endTime = DateTime.tryParse(rxEndTime.value);
      if (startTime != null && endTime != null) {
        final Duration difference = endTime.difference(startTime);
        final double differenceInHours =
            difference.inMilliseconds / Duration.millisecondsPerHour.toDouble();
        return double.parse(differenceInHours.toStringAsFixed(2));
      } else {
        return 0.0;
      }
    }
  }

  Future<bool> checkLocationFunction() async {
    final loc.PermissionStatus status = await loc.Location().hasPermission();
    final bool isGranted = status == loc.PermissionStatus.granted;
    final bool isGrantedLimited = status == loc.PermissionStatus.grantedLimited;

    final bool hasPermission = isGranted || isGrantedLimited;
    final bool serviceEnable = await loc.Location().serviceEnabled();

    final bool value = hasPermission && serviceEnable;
    return Future<bool>.value(value);
  }

  Future<void> requestLocationFunction() async {
    await AppPermService().permissionLocation();
    await AppPermService().serviceLocation();
    return Future<void>.value();
  }

  void setupUIProcedure() {
    final String displayType = rxSelectedCategory.value.displayType ?? "";

    switch (displayType) {
      case displayTypeHour:
        rxNeedToShowAreaWidget(false);
        rxNeedToShowHourWidget(true);
        break;
      case displayTypeArea:
        rxNeedToShowAreaWidget(true);
        rxNeedToShowHourWidget(true);
        break;
      case displayTypeAreaWithMedicine:
        rxNeedToShowAreaWidget(true);
        rxNeedToShowHourWidget(true);
        break;
      default:
        rxNeedToShowAreaWidget(true);
        rxNeedToShowHourWidget(true);
        break;
    }

    return;
  }

  Future<void> openConfirmUpdateRentalCategoryWidget({
    required String oldName,
    required String newName,
    required Function() onPressedUpdate,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Are you sure you want to update $oldName with new $newName?",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: AppElevatedButton(
                    text: "Update with $newName",
                    onPressed: () {
                      AppNavService().pop();

                      onPressedUpdate();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: AppTextButton(
                    text: "Keep $oldName",
                    onPressed: () async {
                      AppNavService().pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 48),
        ],
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }
}
