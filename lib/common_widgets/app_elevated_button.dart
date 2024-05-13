import "dart:async";

import "package:customer/common_widgets/app_maybe_marquee.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:flutter/material.dart";

class AppElevatedButton extends StatefulWidget {
  const AppElevatedButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final Function() onPressed;

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  final StreamController<bool> _controller = StreamController<bool>();
  final FocusNode? primaryFocus = FocusManager.instance.primaryFocus;

  @override
  void initState() {
    super.initState();
    _controller.add(false);
  }

  @override
  void dispose() {
    unawaited(_controller.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: StreamBuilder<bool>(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: AppConstants().elevation,
              padding: EdgeInsets.zero,
              backgroundColor: AppColors().appPrimaryColor,
            ),
            onPressed: snapshot.hasData && snapshot.data == false
                ? () async {
                    unfocusFunction();
                    _controller.add(true);
                    await widget.onPressed();
                    _controller.add(false);
                  }
                : null,
            child: snapshot.hasData && snapshot.data == false
                ? MaybeMarqueeText(
                    text: widget.text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors().appWhiteColor,
                    ),
                    alignment: Alignment.center,
                  )
                : const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

void unfocusFunction() {
  if (primaryFocus?.hasFocus ?? false) {
    primaryFocus?.unfocus();
  } else {}
  return;
}
