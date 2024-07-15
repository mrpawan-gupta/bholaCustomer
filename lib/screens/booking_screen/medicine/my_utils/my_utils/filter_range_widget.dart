import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/controllers/nested_category/products_list_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:syncfusion_flutter_sliders/sliders.dart";

class FilterRangeWidget extends StatefulWidget {
  const FilterRangeWidget({
    required this.minimumRange,
    required this.maximumRange,
    super.key,
  });

  final double minimumRange;
  final double maximumRange;

  @override
  State<FilterRangeWidget> createState() => _FilterRangeWidgetState();
}

class _FilterRangeWidgetState extends State<FilterRangeWidget> {
  final RxDouble rxFilterMinimumRange = defaultMinRange.obs;
  final RxDouble rxFilterMaximumRange = defaultMaxRange.obs;

  @override
  void initState() {
    super.initState();

    rxFilterMinimumRange(widget.minimumRange);
    rxFilterMaximumRange(widget.maximumRange);
  }

  @override
  void dispose() {
    rxFilterMinimumRange.close();
    rxFilterMaximumRange.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
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
            SfRangeSlider(
              min: defaultMinRange,
              max: defaultMaxRange,
              values: SfRangeValues(
                rxFilterMinimumRange.value,
                rxFilterMaximumRange.value,
              ),
              stepSize: 1000,
              interval: 1000,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              activeColor: AppColors().appPrimaryColor,
              onChanged: (SfRangeValues value) {
                rxFilterMinimumRange(value.start);
                rxFilterMaximumRange(value.end);
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("$defaultMinRange"),
                  Text("$defaultMaxRange"),
                ],
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
                          rxFilterMinimumRange(defaultMinRange);
                          rxFilterMaximumRange(defaultMaxRange);
                          AppNavService().pop(
                            (
                              rxFilterMinimumRange.value,
                              rxFilterMaximumRange.value,
                            ),
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
                          rxFilterMinimumRange(rxFilterMinimumRange.value);
                          rxFilterMaximumRange(rxFilterMaximumRange.value);
                          AppNavService().pop(
                            (
                              rxFilterMinimumRange.value,
                              rxFilterMaximumRange.value,
                            ),
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
      },
    );
  }
}
