import "dart:async";

import "package:after_layout/after_layout.dart";
import "package:customer/common_widgets/app_lottie_widget.dart";
import "package:customer/controllers/payment_controller/payment_controller.dart";
import "package:customer/models/phone_pe_res_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/phonepe_sdk_service.dart";
import "package:customer/utils/app_assets_lotties.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with AfterLayoutMixin<PaymentScreen> {
  final PaymentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment Booking Screen"),
        surfaceTintColor: AppColors().appTransparentColor,
        leading: BackButton(onPressed: backDecision),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          } else {}
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
      case PaymentState.success:
        widget = commonAppLottieWidget(AppAssetsLotties().lottiePaymentSuccess);
        break;
      case PaymentState.failure:
        widget = commonAppLottieWidget(AppAssetsLotties().lottiePaymentFailure);
        break;
    }

    return Row(
      children: <Widget>[
        const SizedBox(width: 16),
        Expanded(child: Center(child: widget)),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget lowerWidget() {
    final PhonePeResModel item = controller.rxPhonePeResModel.value;

    final bool cond1 = (item.data?.transactionId ?? "").isNotEmpty;
    final bool cond2 = controller.rxPaymentState.value == PaymentState.success;
    final bool finalCondition = cond1 || cond2;

    String message = "";

    switch (controller.rxPaymentState.value) {
      case PaymentState.notStarted:
        message = "Payment not started";
        break;
      case PaymentState.started:
        message = "Payment started";
        break;
      case PaymentState.processing:
        message = "Payment processing";
        break;
      case PaymentState.success:
        message = "Payment success";
        break;
      case PaymentState.failure:
        message = "Payment failure";
        break;
    }

    return Row(
      children: <Widget>[
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (finalCondition)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Text(
                      "Transaction ID: ${item.data?.transactionId ?? ""}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                  ],
                )
              else
                const SizedBox(),
            ],
          ),
        ),
        const SizedBox(width: 16),
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
    final bool condition1 = controller.canGoBackSuccess();
    final bool condition2 = controller.canGoBackFailure();

    return condition1 && condition2
        ? const SizedBox()
        : !condition1 && condition2
            ? Row(
                children: <Widget>[
                  const SizedBox(width: 16),
                  Expanded(child: backButton()),
                  const SizedBox(width: 16),
                  Expanded(child: retryButton()),
                  const SizedBox(width: 16),
                ],
              )
            : condition1 && !condition2
                ? Row(
                    children: <Widget>[
                      const SizedBox(width: 16),
                      Expanded(child: backButton()),
                      const SizedBox(width: 16),
                      Expanded(child: viewBookingDetailsButton()),
                      const SizedBox(width: 16),
                    ],
                  )
                : !condition1 && !condition2
                    ? const SizedBox()
                    : const SizedBox();
  }

  Widget backButton() {
    return Card(
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
    );
  }

  Widget viewBookingDetailsButton() {
    return Card(
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
        onTap: () async {
          await AppNavService().pushNamed(
            destination: AppRoutes().bookingDetailsScreen,
            arguments: <String, dynamic>{"id": controller.rxBookingId.value},
          );

          AppNavService().pop();
          AppNavService().pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "View Booking Details",
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
    );
  }

  Widget retryButton() {
    return Card(
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
        onTap: () async {
          controller.resetAllPaymentData();

          await initiatePaymentProcedure();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Retry Payment",
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
    );
  }

  void backDecision() {
    final bool canGoBack = controller.canGoBack();

    if (canGoBack) {
      final String route1 = AppRoutes().bookingDetailsScreen;
      final String route2 = AppRoutes().bookingAddOnsScreen;
      final String route3 = AppRoutes().paymentScreen;

      final bool cond1 = AppNavService().previousRoute == route1;
      final bool cond2 = AppNavService().previousRoute == route2;
      final bool cond3 = AppNavService().previousRoute == route3;

      if (cond1 || cond2 || cond3) {
        AppNavService().pop();
        AppNavService().pop();
      } else {
        AppNavService().pop();
      }
    } else {}

    return;
  }

  Future<void> initiatePaymentProcedure() async {
    controller.updatePaymentState(PaymentState.started);

    (bool, String, String) response = (false, "", "");
    response = await controller.bookingTransactionAPICall();

    if (response.$1) {
      controller.updatePaymentState(PaymentState.processing);

      (bool, String) result = (false, "");
      result = await PhonePeSDKService().startTransaction(
        body: response.$2,
        checksum: response.$3,
      );

      if (result.$1) {
        final bool value = await controller.bookingTransactionStatusAPICall();
        value
            ? controller.updatePaymentState(PaymentState.success)
            : controller.updatePaymentState(PaymentState.failure);
        AppSnackbar()
            .snackbarSuccess(title: "Yay!", message: "Payment success");
      } else {
        controller.updatePaymentState(PaymentState.failure);
        AppSnackbar().snackbarFailure(title: "Oops", message: result.$2);
      }
    } else {
      controller.updatePaymentState(PaymentState.failure);
      AppSnackbar().snackbarFailure(title: "Oops", message: "Payment failure");
    }
    return Future<void>.value();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await initiatePaymentProcedure();
    return Future<void>.value();
  }
}
