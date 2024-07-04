import "dart:async";

import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/controllers/cart_controller/cart_controller.dart";
import "package:customer/models/coupon_list_model.dart";
import "package:customer/models/get_all_carts_model.dart";
import "package:customer/screens/cart_screen/my_utils/common_list_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CartScreen extends GetWidget<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart"),
        surfaceTintColor: AppColors().appTransparentColor,
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  await AppNavService().pushNamed(
                    destination: AppRoutes().wishListScreen,
                    arguments: <String, dynamic>{},
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: AppColors().appRedColor,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            return controller.rxItemsList.isEmpty
                ? SizedBox(
                    height: Get.height / 1.5,
                    width: Get.width,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 16),
                          Icon(
                            Icons.shopping_cart,
                            color: AppColors().appPrimaryColor,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Your cart is empty!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Looks like you haven't made your choice yet!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: AppTextButton(
                              text: "Start Shopping",
                              onPressed: () async {
                                await AppNavService().pushNamed(
                                  destination: AppRoutes().productListingScreen,
                                  arguments: <String, dynamic>{},
                                );

                                unawaited(
                                  controller.getAllCartsItemsAPICall(
                                    needLoader: false,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              listView(),
                              const SizedBox(height: 00),
                              addressWidget(),
                              const SizedBox(height: 16),
                              couponWidget(),
                              const SizedBox(height: 8),
                              const Divider(indent: 16, endIndent: 16),
                              const SizedBox(height: 8),
                              orderPaymentWidget(),
                              const SizedBox(height: 8),
                              couponInfo(),
                              const SizedBox(height: 8),
                              const Divider(indent: 16, endIndent: 16),
                              const SizedBox(height: 8),
                              orderPaymentWidget2(),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      buttons(),
                      const SizedBox(height: 16),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget listView() {
    return CommonListView(
      rxItemsList: controller.rxItemsList,
      onTap: (Items item) async {
        await AppNavService().pushNamed(
          destination: AppRoutes().viewGenericProductDetailsScreen,
          arguments: <String, dynamic>{"id": item.productId ?? ""},
        );

        unawaited(controller.getAllCartsItemsAPICall(needLoader: false));
      },
      incQty: (Items item) async {
        bool value = false;
        value = await controller.updateCartAPICall(
          id: item.sId ?? "",
          qty: (item.quantity ?? 0) + 1,
        );

        if (value) {
          unawaited(controller.getAllCartsItemsAPICall(needLoader: false));
        } else {}
      },
      decQty: (Items item) async {
        bool value = false;
        value = await controller.updateCartAPICall(
          id: item.sId ?? "",
          qty: (item.quantity ?? 0) - 1,
        );

        if (value) {
          unawaited(controller.getAllCartsItemsAPICall(needLoader: false));
        } else {}
      },
      onPressedDelete: (Items item) async {
        bool value = false;
        value = await controller.removeItemFromCartAPICall(
          id: item.sId ?? "",
        );

        if (value) {
          unawaited(controller.getAllCartsItemsAPICall(needLoader: false));
        } else {}
      },
    );
  }

  Widget addressWidget() {
    return controller.getAddressOrAddressPlaceholder() == "-"
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Delivery to",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  color: AppColors().appGreyColor.withOpacity(0.16),
                  surfaceTintColor: AppColors().appGreyColor.withOpacity(0.16),
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      controller.getFullName(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      controller.getAddressOrAddressPlaceholder(),
                      style: const TextStyle(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {},
                        child: ColoredBox(
                          color: AppColors().appPrimaryColor.withOpacity(0.16),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit_outlined,
                              color: AppColors().appPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          );
  }

  Widget couponWidget() {
    final Carts item = controller.rxCart.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0,
            margin: EdgeInsets.zero,
            color: AppColors().appTransparentColor,
            surfaceTintColor: AppColors().appTransparentColor,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: (item.coupon?.code ?? "").isNotEmpty
                    ? AppColors().appPrimaryColor
                    : AppColors().appBlackColor,
              ),
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                (item.coupon?.code ?? "").isNotEmpty
                    ? "Coupon applied: ${item.coupon?.code ?? ""}"
                    : "Apply Coupon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (item.coupon?.code ?? "").isNotEmpty
                      ? AppColors().appPrimaryColor
                      : AppColors().appBlackColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: (item.coupon?.code ?? "").isNotEmpty
                    ? AppColors().appPrimaryColor
                    : AppColors().appBlackColor,
              ),
              onTap: () async {
                final dynamic result = await AppNavService().pushNamed(
                  destination: AppRoutes().couponScreen,
                  arguments: item.coupon == null
                      ? <String, dynamic>{}
                      : <String, dynamic>{"id": item.coupon?.sId ?? ""},
                );

                if (result != null && result is Coupons) {
                  final Map<String, dynamic> map1 = result.toJson();
                  final Map<String, dynamic> map2 = Coupons().toJson();
                  final bool isForApplying = !mapEquals(map1, map2);

                  final String code = isForApplying
                      ? (result.code ?? "")
                      : (controller.rxCart.value.coupon?.code ?? "");

                  final bool value = isForApplying
                      ? await controller.applyCouponAPICall(code: code)
                      : await controller.removeCouponAPICall(code: code);

                  if (value) {
                    unawaited(
                      controller.getAllCartsItemsAPICall(needLoader: false),
                    );
                  } else {}
                } else {}
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget orderPaymentWidget() {
    final Carts item = controller.rxCart.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Order Payment Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0,
            margin: EdgeInsets.zero,
            color: AppColors().appTransparentColor,
            surfaceTintColor: AppColors().appTransparentColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Order Amounts:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "₹${item.totalPriceWithoutDiscount ?? 0}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Convenience Fee:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: SizedBox(
                        height: 24,
                        child: AppTextButton(
                          text: "Know more",
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Text(
                        "₹0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Delivery Fee:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        (item.deliveryAmount ?? 0) == 0
                            ? "FREE"
                            : "₹${item.deliveryAmount ?? 0}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (item.deliveryAmount ?? 0) == 0
                              ? AppColors().appPrimaryColor
                              : AppColors().appBlackColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget couponInfo() {
    final Carts item = controller.rxCart.value;
    if (item.coupon == null) {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Coupon code:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item.coupon?.code ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Coupon discount percent:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "${item.coupon?.discountPercent ?? 0}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Coupon max amount:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "₹${item.coupon?.maxamount ?? 0}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }
  }

  Widget orderPaymentWidget2() {
    final Carts item = controller.rxCart.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0,
            margin: EdgeInsets.zero,
            color: AppColors().appTransparentColor,
            surfaceTintColor: AppColors().appTransparentColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Order Total:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "₹${item.totalPriceWithDiscount ?? 0}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons() {
    final Carts item = controller.rxCart.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "₹${item.totalPriceWithDiscount ?? 0}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                  child: AppTextButton(text: "View Details", onPressed: () {}),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: kToolbarHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {},
                  child: ColoredBox(
                    color: AppColors().appPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Proceed to Payment",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors().appWhiteColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
