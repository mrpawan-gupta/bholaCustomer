import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/coupon_controller/coupon_controller.dart";
import "package:customer/models/coupon_list_model.dart";
import "package:customer/screens/coupon_screen/my_utils/common_list_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_debouncer.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CouponScreen extends GetWidget<CouponController> {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Coupons"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: ValueListenableBuilder<PagingState<int, Coupons>>(
          valueListenable: controller.pagingControllerPromo,
          builder: (
            BuildContext context,
            PagingState<int, Coupons> value,
            Widget? child,
          ) {
            return (value.itemList?.isEmpty ?? false)
                ? SizedBox(
                    height: Get.height / 1.5,
                    width: Get.width,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 16),
                          Icon(
                            Icons.discount,
                            color: AppColors().appPrimaryColor,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            " No coupon available at this moment!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Check back in a little bit.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: AppTextButton(
                              text: "Try refreshing",
                              onPressed:
                                  controller.pagingControllerPromo.refresh,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  )
                : Obx(
                    () {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          searchBarWidget(),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              child: reviewsWidget(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buttons(),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  Widget searchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors().appGreyColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 16 + 8),
                  Icon(Icons.search, color: AppColors().appGreyColor),
                  const SizedBox(width: 16 + 8),
                  Expanded(
                    child: AppTextField(
                      controller: controller.searchController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.search,
                      readOnly: false,
                      obscureText: false,
                      maxLines: 1,
                      maxLength: null,
                      onChanged: (String value) {
                        controller.updateSearchQuery(value);

                        AppDebouncer().debounce(
                          controller.pagingControllerPromo.refresh,
                        );
                      },
                      onTap: () {},
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      enabled: true,
                      autofillHints: const <String>[],
                      hintText: "Search here...",
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
        ],
      ),
    );
  }

  Widget reviewsWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonListView(
          pagingController: controller.pagingControllerPromo,
          selectedCoupon: controller.rxSelectedCoupon.value,
          onChanged: controller.updateSelectedCoupon,
        ),
      ],
    );
  }

  Widget buttons() {
    final bool condition = !controller.rxHadCoupon.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: condition
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: AppElevatedButton(
                      text: "Apply Coupon",
                      onPressed: () async {
                        final String reason = controller.validate();
                        if (reason.isEmpty) {
                          final Coupons value =
                              controller.rxSelectedCoupon.value;
                          controller.updateSelectedCoupon(value);

                          AppNavService()
                              .pop(controller.rxSelectedCoupon.value);
                        } else {
                          AppSnackbar().snackbarFailure(
                            title: "Oops",
                            message: reason,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: AppElevatedButton(
                      text: "Remove Coupon",
                      onPressed: () async {
                        final Coupons value = Coupons();
                        controller.updateSelectedCoupon(value);

                        AppNavService().pop(controller.rxSelectedCoupon.value);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: AppElevatedButton(
                      text: "Apply Coupon",
                      onPressed: () async {
                        final String reason = controller.validate();
                        if (reason.isEmpty) {
                          final Coupons value =
                              controller.rxSelectedCoupon.value;
                          controller.updateSelectedCoupon(value);

                          AppNavService()
                              .pop(controller.rxSelectedCoupon.value);
                        } else {
                          AppSnackbar().snackbarFailure(
                            title: "Oops",
                            message: reason,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
