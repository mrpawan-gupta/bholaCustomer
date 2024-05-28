import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class FilterCategoryByWidget extends StatefulWidget {
  const FilterCategoryByWidget({
    required this.selectedCategory,
    required this.categoriesList,
    super.key,
  });

  final Categories selectedCategory;
  final List<Categories> categoriesList;

  @override
  State<FilterCategoryByWidget> createState() => _FilterCategoryByWidgetState();
}

class _FilterCategoryByWidgetState extends State<FilterCategoryByWidget> {
  final Rx<Categories> rxFilterSelectedCategory = Categories().obs;

  @override
  void initState() {
    super.initState();

    rxFilterSelectedCategory(widget.selectedCategory);
  }

  @override
  void dispose() {
    rxFilterSelectedCategory.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.categoriesList.length,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (BuildContext context, int index) {
              final Categories item = widget.categoriesList[index];
              return Obx(
                () {
                  return RadioListTile<Categories>(
                    dense: true,
                    value: item,
                    groupValue: rxFilterSelectedCategory.value,
                    title: Text(item.name ?? ""),
                    onChanged: rxFilterSelectedCategory,
                    activeColor: AppColors().appPrimaryColor,
                    toggleable: true,
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: AppTextButton(
                    text: "Clear",
                    onPressed: () {
                      rxFilterSelectedCategory(
                        Categories(),
                      );
                      AppNavService().pop(
                        rxFilterSelectedCategory.value,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: AppElevatedButton(
                    text: "Apply",
                    onPressed: () {
                      rxFilterSelectedCategory(
                        rxFilterSelectedCategory.value,
                      );
                      AppNavService().pop(
                        rxFilterSelectedCategory.value,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 48),
      ],
    );
  }
}
