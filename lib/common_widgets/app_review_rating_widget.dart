import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:get/get.dart";

class AppReviewRatingWidget extends StatefulWidget {
  const AppReviewRatingWidget({
    required this.initialReview,
    required this.initialRating,
    super.key,
  });

  final String initialReview;
  final num initialRating;

  @override
  State<AppReviewRatingWidget> createState() => _AppReviewRatingWidgetState();
}

class _AppReviewRatingWidgetState extends State<AppReviewRatingWidget> {
  final TextEditingController _reviewController = TextEditingController();
  final RxString _rxReview = "".obs;
  final Rx<num> _rxRating = 1.obs;

  @override
  void initState() {
    super.initState();

    _reviewController.text = widget.initialReview;
    _rxReview(widget.initialReview);
    _rxRating(widget.initialRating.toInt());
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _rxReview.close();
    _rxRating.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext context, bool isKeyboardVisible) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              AppLanguageKeys().strActionPerform.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Add Rating",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              minRating: 1.0,
              maxRating: 5.0,
              initialRating: _rxRating.value.toDouble(),
              itemSize: 32,
              unratedColor: AppColors().appGrey,
              itemBuilder: (BuildContext context, int index) {
                return Icon(Icons.star, color: AppColors().appOrangeColor);
              },
              onRatingUpdate: (double value) {
                _rxRating(value.toInt());
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Add Review",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors().appGreyColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      const SizedBox(width: 16 + 8),
                      Expanded(
                        child: AppTextField(
                          controller: _reviewController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          readOnly: false,
                          obscureText: false,
                          maxLines: 5,
                          maxLength: null,
                          onChanged: _rxReview,
                          onTap: () {},
                          inputFormatters: const <TextInputFormatter>[],
                          enabled: true,
                          autofillHints: const <String>[],
                          hintText: "Item is good...",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors().appGreyColor,
                          ),
                          prefixIcon: null,
                          suffixIcon: null,
                        ),
                      ),
                      const SizedBox(width: 16 + 8),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 50,
                child: AppElevatedButton(
                  text: "Send Ratings & Reviews",
                  onPressed: () {
                    final (num, String) result = (
                      _rxRating.value,
                      _rxReview.value,
                    );

                    AppNavService().pop(result);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(height: isKeyboardVisible ? 0 : 48),
          ],
        );
      },
    );
  }
}
