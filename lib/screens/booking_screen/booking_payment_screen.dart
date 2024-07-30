import "dart:async";

import "package:after_layout/after_layout.dart";
import "package:customer/common_widgets/app_lottie_widget.dart";
import "package:customer/controllers/booking_controller/booking_payment_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/phonepe_sdk_service.dart";
import "package:customer/utils/app_assets_lotties.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment Booking Screen"),
        surfaceTintColor: AppColors().appTransparentColor,
        leading: BackButton(onPressed: backDecision),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          backDecision();
          return Future<bool>.value(false);
        },
        child: SafeArea(
          child: Obx(
            () {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    upperWidget(),
                    const SizedBox(height: 16),
                    lowerWidget(),
                    const Spacer(),
                    button(),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget upperWidget() {
    Widget widget = const SizedBox();
    switch (controller.rxPaymentState.value) {
      case PaymentState.notStarted:
        widget = CircularProgressIndicator(color: AppColors().appPrimaryColor);
        break;
      case PaymentState.started:
        widget = CircularProgressIndicator(color: AppColors().appPrimaryColor);
        break;
      case PaymentState.processing:
        widget = CircularProgressIndicator(color: AppColors().appPrimaryColor);
        break;
      case PaymentState.paymemtSuccess:
        widget = commonAppLottieWidget(AppAssetsLotties().lottiePaymentSuccess);
        break;
      case PaymentState.paymentFailure:
        widget = commonAppLottieWidget(AppAssetsLotties().lottiePaymentFailure);
        break;
    }
    return widget;
  }

  Widget lowerWidget() {
    Widget widget = const SizedBox();
    switch (controller.rxPaymentState.value) {
      case PaymentState.notStarted:
        widget = const Text("Payment not started");
        break;
      case PaymentState.started:
        widget = const Text("Payment started");
        break;
      case PaymentState.processing:
        widget = const Text("Payment processing");
        break;
      case PaymentState.paymemtSuccess:
        widget = const Text("Payment success");
        break;
      case PaymentState.paymentFailure:
        widget = const Text("Payment failure");
        break;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget,
        const SizedBox(height: 16),
        Text(controller.rxMessage.value),
      ],
    );
  }

  Widget commonAppLottieWidget(String path) {
    return AppLottieWidget(
      path: path,
      fit: BoxFit.contain,
      height: Get.width,
      width: Get.width,
      repeat: true,
      onLoaded: (LottieComposition composition) async {},
    );
  }

  Widget button() {
    return controller.canGoBack()
        ? Row(
            children: <Widget>[
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: AppColors().appBlackColor),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  surfaceTintColor: AppColors().appWhiteColor,
                  color: AppColors().appWhiteColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: backDecision,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "Go back",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors().appBlackColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          )
        : const SizedBox();
  }

  void backDecision() {
    final bool canGoBack = controller.canGoBack();
    if (canGoBack) {
      if (AppNavService().previousRoute == AppRoutes().bookingAddOnsScreen) {
        AppNavService().pop();
        AppNavService().pop();
      } else {
        AppNavService().pop();
      }
    } else {}
    return;
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    (bool, String, String) response = (false, "", "");
    response = await controller.createOrderAPICall();

    if (response.$1) {
      controller.updatePaymentState(PaymentState.processing);

      (bool, String) result = (false, "");
      result = await PhonePeSDKService().startTransaction(
        body: response.$2,
        checksum: response.$3,
      );

      if (result.$1) {
        controller
          ..updatePaymentState(PaymentState.paymemtSuccess)
          ..updateMessage(result.$2);

        AppSnackbar().snackbarSuccess(title: "Yay!", message: result.$2);
      } else {
        controller
          ..updatePaymentState(PaymentState.paymentFailure)
          ..updateMessage(result.$2);

        AppSnackbar().snackbarFailure(title: "Oops", message: result.$2);
      }
    } else {
      controller
        ..updatePaymentState(PaymentState.paymentFailure)
        ..updateMessage("Payment failure");

      AppSnackbar().snackbarFailure(title: "Oops", message: "Payment failure");
    }
    return Future<void>.value();
  }
}
