import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/booking_controller/select_crop_controller.dart";
import "package:customer/models/crop_categories_model.dart";
import "package:customer/models/get_all_crops_model.dart";
import "package:customer/screens/booking_screen/crop/my_utils/common_grid_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_debouncer.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class SelectCropScreen extends GetView<SelectCropController> {
  const SelectCropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Crop"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: ValueListenableBuilder<PagingState<int, Crops>>(
          valueListenable: controller.pagingControllerCrops,
          builder: (
            BuildContext context,
            PagingState<int, Crops> value,
            Widget? child,
          ) {
            final Map<String, dynamic> map1 =
                controller.rxSelectedCategory.value.toJson();
            final Map<String, dynamic> map2 = CropCategories().toJson();

            final bool isMapEquals = mapEquals(map1, map2);
            return (value.itemList?.isEmpty ?? false)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      searchBarWidget(),
                      const SizedBox(height: 16),
                      chipSelection(),
                      const Spacer(),
                      Icon(
                        Icons.yard_outlined,
                        color: AppColors().appPrimaryColor,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.rxSearchQuery.value.isEmpty && isMapEquals
                            ? "No crops available at this moment!"
                            : "No crops found in this keyword!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.rxSearchQuery.value.isEmpty && isMapEquals
                            ? "Check back in a little bit."
                            : "Try changing/removing search keyword or category",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: AppTextButton(
                          text: controller.rxSearchQuery.value.isEmpty &&
                                  isMapEquals
                              ? "Try refreshing"
                              : "Clear filers",
                          onPressed: () {
                            final List<CropCategories> tempList = controller
                                    .pagingControllerCategories.itemList ??
                                <CropCategories>[];

                            if (tempList.isNotEmpty) {
                              final CropCategories item = tempList.first;
                              controller.updateSelectedCategory(item);
                            } else {}

                            controller.searchController.text = "";
                            controller.updateSearchQuery("");
                            controller.pagingControllerCrops.refresh();
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      searchBarWidget(),
                      const SizedBox(height: 16),
                      chipSelection(),
                      const SizedBox(height: 16),
                      gridView(),
                      const SizedBox(height: 16),
                    ],
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
                          controller.pagingControllerCrops.refresh,
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

  Widget chipSelection() {
    return ValueListenableBuilder<PagingState<int, Crops>>(
      valueListenable: controller.pagingControllerCrops,
      builder: (
        BuildContext context,
        PagingState<int, Crops> value,
        Widget? child,
      ) {
        final Map<String, dynamic> map1 =
            controller.rxSelectedCategory.value.toJson();
        final Map<String, dynamic> map2 = CropCategories().toJson();

        final bool isMapEquals = mapEquals(map1, map2);
        return (isMapEquals && (value.itemList?.isEmpty ?? false)) ||
                isMapEquals && (value.itemList?.isEmpty ?? true)
            ? const SizedBox(height: 16)
            : SizedBox(
                height: 32 + 8,
                width: double.infinity,
                child: PagedListView<int, CropCategories>(
                  shrinkWrap: true,
                  pagingController: controller.pagingControllerCategories,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  builderDelegate: PagedChildBuilderDelegate<CropCategories>(
                    noItemsFoundIndicatorBuilder: (BuildContext context) {
                      return const SizedBox();
                    },
                    itemBuilder:
                        (BuildContext context, CropCategories item, int index) {
                      final List<CropCategories> itemList =
                          controller.pagingControllerCategories.itemList ??
                              <CropCategories>[];
                      final int length = itemList.length;
                      final bool isLast = index == length - 1;
                      return Obx(
                        () {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: isLast ? 0.0 : 16.0,
                              bottom: 4,
                            ),
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 4,
                              color: controller.rxSelectedCategory.value == item
                                  ? AppColors().appPrimaryColor
                                  : AppColors().appWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(
                                  color: AppColors().appPrimaryColor,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              surfaceTintColor:
                                  controller.rxSelectedCategory.value == item
                                      ? AppColors().appPrimaryColor
                                      : AppColors().appWhiteColor,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                onTap: () async {
                                  controller.updateSelectedCategory(item);
                                  controller.pagingControllerCrops.refresh();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      item.name ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: controller
                                                    .rxSelectedCategory.value ==
                                                item
                                            ? AppColors().appWhiteColor
                                            : AppColors().appPrimaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
      },
    );
  }

  Widget gridView() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: CommonGridView(
              pagingController: controller.pagingControllerCrops,
              onTap: (Crops item) async {
                controller.updateSelectedCrop(item);

                AppNavService().pop(item);
              },
              type: "crops list",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openAskForMedicineWidget({
    required Function() onPressedAccept,
    required Function() onPressedReject,
  }) async {
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            AppLanguageKeys().strActionPerform.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Do you want to add-one respective medicine?",
              style: TextStyle(fontWeight: FontWeight.bold),
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
                    child: AppElevatedButton(
                      text: "No",
                      onPressed: () {
                        AppNavService().pop();

                        onPressedReject();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: AppElevatedButton(
                      text: "Yes",
                      onPressed: () {
                        AppNavService().pop();

                        onPressedAccept();
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
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }
}
