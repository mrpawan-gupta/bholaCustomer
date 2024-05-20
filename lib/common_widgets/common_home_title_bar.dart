import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get_utils/src/extensions/internacionalization.dart";


class CommonHomeTitleBar extends StatelessWidget {
  const CommonHomeTitleBar({
    required this.title,
    required this.onTapViewAll,
    super.key,
  });

  final String title;
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
        ),
      ],
    );
  }
}
