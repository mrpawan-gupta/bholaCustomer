import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";

class AppBottomIndicator extends StatelessWidget {
  const AppBottomIndicator({
    required this.length,
    required this.index,
    super.key,
  });

  final int length;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: _buildPageIndicator());
  }

  List<Widget> _buildPageIndicator() {
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < length; i++) {
      list.add(i == index ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool pos) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: pos ? 10 : 8.0,
        width: pos ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            if (pos)
              BoxShadow(
                color: AppColors().appPrimaryColor,
                blurRadius: 4.0,
                spreadRadius: 1.0,
              )
            else
              BoxShadow(
                color: AppColors().appTransparentColor,
              ),
          ],
          shape: BoxShape.circle,
          color: pos ? AppColors().appPrimaryColor : AppColors().appGreyColor,
        ),
      ),
    );
  }
}
