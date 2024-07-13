import "package:customer/screens/outer_main_screens/category/my_utils/common_horizontal_grid_view.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";

class CommonCategoryTitleBar extends StatelessWidget {
  const CommonCategoryTitleBar({
    required this.title,
    required this.isViewAllNeeded,
    required this.onTapViewAll,
    required this.itemType,
    super.key,
  });

  final String title;
  final bool isViewAllNeeded;
  final Function() onTapViewAll;
  final Types itemType;

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
                  itemType == Types.categories
                      ? "View All"
                      : itemType == Types.services
                          ? "Book Now"
                          : "",
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
