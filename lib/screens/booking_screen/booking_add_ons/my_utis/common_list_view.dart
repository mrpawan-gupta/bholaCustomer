import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/get_booking_medicine_details.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:get/get.dart";

class CommonListView extends StatelessWidget {
  const CommonListView({
    required this.rxMedicinesList,
    required this.onTap,
    required this.incQty,
    required this.decQty,
    required this.onPressedDelete,
    super.key,
  });

  final RxList<Medicines> rxMedicinesList;
  final Function(Medicines item) onTap;
  final Function(Medicines item) incQty;
  final Function(Medicines item) decQty;
  final Function(Medicines item) onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: rxMedicinesList.length,
      padding: EdgeInsets.zero,
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (BuildContext context, int index) {
        final Medicines item = rxMedicinesList[index];
        return listAdapter(item);
      },
    );
  }

  Widget listAdapter(Medicines item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Slidable(
        startActionPane: actionPane(item: item),
        endActionPane: actionPane(item: item),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0,
          margin: EdgeInsets.zero,
          color: AppColors().appPrimaryColor.withOpacity(0.16),
          surfaceTintColor: AppColors().appPrimaryColor.withOpacity(0.16),
          child: InkWell(
            onTap: () async {
              onTap(item);
            },
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ColoredBox(
                          color: AppColors().appWhiteColor,
                          child: CommonImageWidget(
                            imageUrl: item.medicine?.photo ?? "",
                            fit: BoxFit.contain,
                            imageType: ImageType.image,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.medicine?.name ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.medicine?.brand ?? "",
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "₹${item.totalPrice ?? ""}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors().appPrimaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              if ((item.quantity ?? 0) > 1) {
                                decQty(item);
                              } else {
                                await openDeleteBookingItemWidget(
                                  item: item,
                                  onPressedDelete: onPressedDelete,
                                );
                              }
                            },
                            child: ColoredBox(
                              color: AppColors().appRedColor.withOpacity(0.16),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors().appRedColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${item.quantity ?? ""}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              if ((item.quantity ?? 0) < 100) {
                                incQty(item);
                              } else {}
                            },
                            child: ColoredBox(
                              color:
                                  AppColors().appPrimaryColor.withOpacity(0.16),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add,
                                  color: AppColors().appPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openDeleteBookingItemWidget({
    required Medicines item,
    required Function(Medicines item) onPressedDelete,
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
              "Are you sure you want to delete? It is an irreversible process!",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: AppElevatedButton(
                    text: "Do not delete booking item",
                    onPressed: () {
                      AppNavService().pop();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: AppTextButton(
                    text: "Delete booking item",
                    onPressed: () async {
                      AppNavService().pop();

                      onPressedDelete(item);
                    },
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

  ActionPane actionPane({required Medicines item}) {
    return ActionPane(
      extentRatio: 0.24,
      motion: const ScrollMotion(),
      children: <Widget>[
        SlidableAction(
          borderRadius: BorderRadius.circular(12.0),
          onPressed: (BuildContext context) async {
            await openDeleteBookingItemWidget(
              item: item,
              onPressedDelete: onPressedDelete,
            );
          },
          backgroundColor: AppColors().appRedColor,
          foregroundColor: AppColors().appWhiteColor,
          icon: Icons.delete_outline,
        ),
      ],
    );
  }
}
