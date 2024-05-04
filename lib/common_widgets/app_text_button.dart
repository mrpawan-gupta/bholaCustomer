import "dart:async";

import "package:customer/utils/app_constants.dart";
import "package:flutter/material.dart";

class AppTextButton extends StatefulWidget {
  const AppTextButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final Function() onPressed;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
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
      width: double.infinity,
      child: StreamBuilder<bool>(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return TextButton(
            style: TextButton.styleFrom(
              elevation: AppConstants().elevation,
              padding: EdgeInsets.zero,
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
                ? Text(widget.text)
                : const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
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
