import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
// import "package:customer/models/featured_model.dart";

class FilterSortByWidget extends StatefulWidget {
  const FilterSortByWidget({
    required this.selectedSortBy,
    required this.sortByList,
    super.key,
  });

  final String selectedSortBy;
  final List<String> sortByList;

  @override
  State<FilterSortByWidget> createState() => _FilterSortByWidgetState();
}

class _FilterSortByWidgetState extends State<FilterSortByWidget> {
  final RxString rxFilterSelectedSortBy = "".obs;

  @override
  void initState() {
    super.initState();

    rxFilterSelectedSortBy(widget.selectedSortBy);
  }

  @override
  void dispose() {
    rxFilterSelectedSortBy.close();

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
            itemCount: widget.sortByList.length,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (BuildContext context, int index) {
              final String item = widget.sortByList[index];
              return Obx(
                () {
                  return RadioListTile<String>(
                    dense: true,
                    value: item,
                    groupValue: rxFilterSelectedSortBy.value,
                    title: Text(item),
                    onChanged: rxFilterSelectedSortBy,
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
                      rxFilterSelectedSortBy(
                        "",
                      );
                      AppNavService().pop(
                        rxFilterSelectedSortBy.value,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: AppElevatedButton(
                    text: "Apply",
                    onPressed: () {
                      rxFilterSelectedSortBy(
                        rxFilterSelectedSortBy.value,
                      );
                      AppNavService().pop(
                        rxFilterSelectedSortBy.value,
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
