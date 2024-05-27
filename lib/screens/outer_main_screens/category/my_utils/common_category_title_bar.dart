import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CommonCategoryTitleBar extends StatelessWidget {
  const CommonCategoryTitleBar({
    required this.title,
    required this.isViewAllNeeded,
    required this.onTapViewAll,
    super.key,
  });

  final String title;
  final bool isViewAllNeeded;
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
