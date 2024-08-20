// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:feature_discovery/feature_discovery.dart";
import "package:flutter/material.dart";

String featureTopProfile = "featureTopProfile";
String featureTopWishList = "featureTopWishList";
String featureTopCartList = "featureTopCartList";
String featurBottomHome = "featurBottomHome";
String featurBottomCategory = "featurBottomCategory";
String featurBottomBooking = "featurBottomBooking";
String featurBottomLive = "featurBottomLive";
String featurBottomOrderHistory = "featurBottomOrderHistory";

class FeatureDiscoveryOverlay extends StatelessWidget {
  const FeatureDiscoveryOverlay({
    required this.featureId,
    required this.tapTarget,
    required this.child,
    super.key,
  });
  final String featureId;
  final Widget tapTarget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
      featureId: featureId,
      tapTarget: tapTarget,
      overflowMode: OverflowMode.extendBackground,
      title: Text(
        title(featureId),
      ),
      description: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            desc(featureId),
          ),
          const SizedBox(height: 32),
          AppElevatedButton(
            text: featureId == featurBottomOrderHistory ? "Done" : "Next",
            onPressed: () async {
              await FeatureDiscovery.completeCurrentStep(context);
              if (featureId == featurBottomOrderHistory) {
                await onComplete();
              } else {}
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
      textColor: Theme.of(context).scaffoldBackgroundColor,
      targetColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).colorScheme.primary,
      onOpen: () async {
        if (featureId == featureTopProfile) {
        } else if (featureId == featureTopWishList) {
        } else if (featureId == featureTopCartList) {
        } else if (featureId == featurBottomHome) {
          await tabControllerFunction(0);
        } else if (featureId == featurBottomCategory) {
          await tabControllerFunction(1);
        } else if (featureId == featurBottomBooking) {
          await tabControllerFunction(2);
        } else if (featureId == featurBottomLive) {
          await tabControllerFunction(3);
        } else if (featureId == featurBottomOrderHistory) {
          await tabControllerFunction(4);
        } else {}
        return Future<bool>.value(true);
      },
      onBackgroundTap: () {
        return Future<bool>.value(true);
      },
      onComplete: () {
        return Future<bool>.value(true);
      },
      // onDismiss: () {
      //   return Future<bool>.value(true);
      // },
      barrierDismissible: false,
      child: child,
    );
  }

  Future<void> onComplete() async {
    await tabControllerFunction(0);
    return Future<void>.value();
  }
}

String title(String featureId) {
  String returnString = "";

  if (featureId == featureTopProfile) {
    returnString = "Profile";
  } else if (featureId == featureTopWishList) {
    returnString = "Wish List";
  } else if (featureId == featureTopCartList) {
    returnString = "Cart List";
  } else if (featureId == featurBottomHome) {
    returnString = "Home";
  } else if (featureId == featurBottomCategory) {
    returnString = "Category";
  } else if (featureId == featurBottomBooking) {
    returnString = "Booking";
  } else if (featureId == featurBottomLive) {
    returnString = "Live";
  } else if (featureId == featurBottomOrderHistory) {
    returnString = "Order History";
  } else {}

  return returnString;
}

String desc(String featureId) {
  String returnString = "";

  if (featureId == featureTopProfile) {
    returnString = "";
  } else if (featureId == featureTopWishList) {
    returnString = "";
  } else if (featureId == featureTopCartList) {
    returnString = "";
  } else if (featureId == featurBottomHome) {
    returnString = "";
  } else if (featureId == featurBottomCategory) {
    returnString = "";
  } else if (featureId == featurBottomBooking) {
    returnString = "";
  } else if (featureId == featurBottomLive) {
    returnString = "";
  } else if (featureId == featurBottomOrderHistory) {
    returnString = "";
  } else {}

  return returnString;
}
