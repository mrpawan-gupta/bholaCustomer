import "package:customer/controllers/product_detail_page_controllers/cart_controllers.dart";
import "package:customer/screens/widgets/text_widgets.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  Widget slideLeftBackground() {
    return ColoredBox(
      color: AppColors().appRedColor,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: AppColors().appWhiteColor,
            ),
            Text(
              AppLanguageKeys().strDelete.tr,
              style: TextStyle(
                color: AppColors().appWhiteColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          CupertinoIcons.back,
          size: 33,
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: TextWidget(
          text: AppLanguageKeys().strShoppingBag.tr,
          color: AppColors().appBlackColor,
          size: 25,
          fontWeight: FontWeight.bold,
          isLineThrough: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 2, 16, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Dismissible(
                secondaryBackground: slideLeftBackground(),
                background: slideLeftBackground(),
                key: UniqueKey(),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors().appGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors().appPrimaryColor,
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // Image border
                              child: SizedBox(
                                width: 90,
                                height: 100,
                                child: Image.asset(
                                  AppAssetsImages.tractor,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextWidget(
                                      text: AppLanguageKeys().strTractor.tr,
                                      color: AppColors().appPrimaryColor,
                                      size: 16,
                                      fontWeight: FontWeight.bold,
                                      isLineThrough: false,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                      text: AppLanguageKeys().strFarmTool.tr,
                                      color: AppColors().appBlackColor,
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                      isLineThrough: false,
                                    ),
                                  ],
                                ),
                                TextWidget(
                                  text: "₹1000",
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  isLineThrough: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors().appPrimaryColor,
                          ),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors().appWhiteColor,
                                  size: 16,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColors().appWhiteColor,
                                ),
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                    color: AppColors().appBlackColor,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.add,
                                  color: AppColors().appWhiteColor,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().appGreyColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green.shade100,
                ),
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 90,
                              height: 100,
                              child: Image.asset(
                                AppAssetsImages.tractor,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextWidget(
                                    text: AppLanguageKeys().strTractor.tr,
                                    color: AppColors().appPrimaryColor,
                                    size: 16,
                                    fontWeight: FontWeight.bold,
                                    isLineThrough: false,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextWidget(
                                    text: AppLanguageKeys().strFarmTool.tr,
                                    color: AppColors().appBlackColor,
                                    size: 14,
                                    fontWeight: FontWeight.w400,
                                    isLineThrough: false,
                                  ),
                                ],
                              ),
                              TextWidget(
                                text: "₹1000",
                                color: AppColors().appBlackColor,
                                size: 14,
                                fontWeight: FontWeight.w600,
                                isLineThrough: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors().appPrimaryColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.remove,
                                color: AppColors().appWhiteColor,
                                size: 16,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: AppColors().appWhiteColor,
                              ),
                              child: Text(
                                "3",
                                style: TextStyle(
                                  color: AppColors().appBlackColor,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.add,
                                color: AppColors().appWhiteColor,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextWidget(
                text: AppLanguageKeys().strDeliveryAddress.tr,
                color: AppColors().appBlackColor,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors().appGreyColor,
                ),
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextWidget(
                            text: AppLanguageKeys().strRohan.tr,
                            color: AppColors().appBlackColor,
                            size: 16,
                            fontWeight: FontWeight.bold,
                            isLineThrough: false,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.4,
                            child: Text(
                              AppLanguageKeys().strText.tr,
                              style: TextStyle(
                                color: AppColors().appGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.edit_calendar_rounded,
                        color: AppColors().appPrimaryColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().appGreyColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors().appTransparentColor,
                ),
                height: 40,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLanguageKeys().strCoupon.tr,
                      ),
                      Image.asset(
                        AppAssetsImages.blackright,
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.2,
                  child: const Divider(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: AppLanguageKeys().strDetails.tr,
                color: AppColors().appBlackColor,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextWidget(
                        text: AppLanguageKeys().strOrderAmount.tr,
                        color: AppColors().appBlackColor,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          TextWidget(
                            text: AppLanguageKeys().strConvenience.tr,
                            color: AppColors().appBlackColor,
                            size: 15,
                            fontWeight: FontWeight.w500,
                            isLineThrough: false,
                          ),
                          TextWidget(
                            text: AppLanguageKeys().strKnow.tr,
                            color: AppColors().appPrimaryColor,
                            size: 13,
                            fontWeight: FontWeight.w500,
                            isLineThrough: false,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextWidget(
                        text: AppLanguageKeys().strDelivery.tr,
                        color: AppColors().appBlackColor,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextWidget(
                        text: "₹ 7000",
                        color: AppColors().appBlackColor,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextWidget(
                        text: AppLanguageKeys().strApply.tr,
                        color: AppColors().appPrimaryColor,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextWidget(
                        text: AppLanguageKeys().strFree.tr,
                        color: AppColors().appPrimaryColor,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.2,
                  child: const Divider(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: AppLanguageKeys().strOrder.tr,
                    color: AppColors().appBlackColor,
                    size: 16,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                  TextWidget(
                    text: "₹ 7000",
                    color: AppColors().appBlackColor,
                    size: 16,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextWidget(
                        text: "₹ 7000",
                        color: AppColors().appBlackColor,
                        size: 16,
                        fontWeight: FontWeight.bold,
                        isLineThrough: false,
                      ),
                      TextWidget(
                        text: AppLanguageKeys().strView.tr,
                        color: AppColors().appBlackColor,
                        size: 12,
                        fontWeight: FontWeight.bold,
                        isLineThrough: false,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.8,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          AppColors().appWhiteColor,
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors().appPrimaryColor,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: AppColors().appPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {},
                      child: Text(
                        AppLanguageKeys().strProceed.tr.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
