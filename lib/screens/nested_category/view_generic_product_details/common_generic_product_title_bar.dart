import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CommonGenericProductTitleBar extends StatelessWidget {
  const CommonGenericProductTitleBar({
    required this.title,
    required this.isReviewRatingNeeded,
    required this.isViewAllNeeded,
    required this.onTapReviewRating,
    required this.onTapViewAll,
    super.key,
  });

  final String title;
  final bool isReviewRatingNeeded;
  final bool isViewAllNeeded;
  final Function() onTapReviewRating;
  final Function() onTapViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16 + 4,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isReviewRatingNeeded)
          Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24.0),
              onTap: onTapReviewRating,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add Review Rating",
                  style: TextStyle(color: AppColors().appPrimaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        else
          const SizedBox(),
        if (isViewAllNeeded)
          Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24.0),
              onTap: onTapViewAll,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLanguageKeys().strViewAll.tr,
                  style: TextStyle(color: AppColors().appPrimaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
