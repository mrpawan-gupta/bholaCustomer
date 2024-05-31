import "package:customer/common_widgets/app_text_button.dart";
import "package:flutter/material.dart";

class AppNoItemFoundWidget extends StatelessWidget {
  const AppNoItemFoundWidget({
    required this.title,
    required this.message,
    required this.onTryAgain,
    super.key,
  });

  final String title;
  final String message;
  final void Function() onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 50,
            width: 100,
            child: AppTextButton(
              text: "Try Again",
              onPressed: onTryAgain,
            ),
          ),
        ],
      ),
    );
  }
}
