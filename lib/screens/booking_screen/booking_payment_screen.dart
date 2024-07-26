import "dart:async";

import "package:after_layout/after_layout.dart";
import "package:customer/controllers/booking_controller/booking_payment_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/phonepe_sdk_service.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class BookingPaymentScreen extends StatefulWidget {
  const BookingPaymentScreen({super.key});

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen>
    with AfterLayoutMixin<BookingPaymentScreen> {
  final BookingPaymentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void backDecision() {
    if (AppNavService().previousRoute == AppRoutes().bookingAddOnsScreen) {
      AppNavService().pop();
      AppNavService().pop();
    } else {
      AppNavService().pop();
    }
    return;
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    (bool, String, String) response = (false, "", "");
    response = await controller.createOrderAPICall();

    if (response.$1) {
      (bool, String) result = (false, "");
      result = await PhonePeSDKService().startTransaction(
        body: response.$2,
        checksum: response.$3,
      );
      result.$1
          ? AppSnackbar().snackbarSuccess(title: "Yay!", message: result.$2)
          : AppSnackbar().snackbarFailure(title: "Oops", message: result.$2);
    } else {
      AppSnackbar().snackbarFailure(title: "Oops", message: "");
    }

    backDecision();
    return Future<void>.value();
  }
}
