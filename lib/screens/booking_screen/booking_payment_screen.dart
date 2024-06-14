import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/controllers/booking_controller/booking_payment_controller.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class BookingPaymentScreen extends GetView<BookingPaymentController> {
  const BookingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment Booking Screen"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Booking ID: ${controller.rxBookingId.value}"),
              const SizedBox(height: 32),
              const Text("This is our Payment Booking Screen"),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AppElevatedButton(
                  text: "Payment Gateway Coming Soon",
                  onPressed: () {
                    AppSnackbar().snackbarFailure(
                      title: "Oops!",
                      message: "Coming Soon!",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
