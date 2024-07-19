// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/models/create_booking.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class VendorUnavailable extends StatelessWidget {
  const VendorUnavailable({
    required this.data,
    required this.onPressedConfirm,
    required this.onPressedSupport,
    super.key,
  });

  final CreateBookingData data;
  final Function() onPressedConfirm;
  final Function() onPressedSupport;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "The selected service is currently not available in your area. Try Selecting the different service or contact the support team.",
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
                  text: "Confirm Booking",
                  onPressed: () {
                    AppNavService().pop();
                    
                    onPressedConfirm();
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: AppTextButton(
                  text: "Contact Support",
                  onPressed: () async {
                    AppNavService().pop();

                    onPressedSupport();
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 48),
      ],
    );
  }
}
