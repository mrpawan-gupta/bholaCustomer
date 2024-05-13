import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";

class CommonGradient extends StatelessWidget {
  const CommonGradient({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: kTextTabBarHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
              AppColors().appBlackColor,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
