import "package:customer/controllers/product_detail_page_controllers/product_detail_page_controllers.dart";
import "package:customer/screens/widgets/conversation_list_widgets.dart";
import "package:customer/screens/widgets/text_widgets.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors().appGreyColor,
                    ),
                    height: 440,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColors().appWhiteColor,
                      ),
                      child: const Icon(
                        CupertinoIcons.back,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 165,
                    left: 10,
                    child: Image.asset(
                      AppAssetsImages.back,
                      height: 50,
                      color: AppColors().appBlackColor,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    child: Image.asset(
                      AppAssetsImages.product,
                      height: 400,
                    ),
                  ),
                  Positioned(
                    top: 165,
                    right: 10,
                    child: Image.asset(
                      AppAssetsImages.blackright,
                      height: 50,
                      color: Colors.black87,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    child: Container(
                      height: 70,
                      width: MediaQuery.sizeOf(context).width / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors().appWhiteColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: ColoredBox(
                                  color: AppColors().appGreyColor,
                                  child: Image.asset(
                                    AppAssetsImages.product,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: ColoredBox(
                                  color: Colors.grey.shade400,
                                  child: Image.asset(
                                    AppAssetsImages.product,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: ColoredBox(
                                  color: AppColors().appGreyColor,
                                  child: Image.asset(
                                    AppAssetsImages.product,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: ColoredBox(
                                  color: Colors.grey.shade400,
                                  child: Image.asset(
                                    AppAssetsImages.product,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: ColoredBox(
                                  color: AppColors().appGreyColor,
                                  child: Image.asset(
                                    AppAssetsImages.product,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextWidget(
                text: AppLanguageKeys().strAmul.tr,
                color: AppColors().appBlackColor,
                size: 22,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
              Row(
                children: <Widget>[
                  TextWidget(
                    text: "₹199",
                    color: AppColors().appBlackColor,
                    size: 18,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextWidget(
                    text: AppLanguageKeys().strMRP.tr,
                    color: AppColors().appGreyColor,
                    size: 17,
                    fontWeight: FontWeight.w600,
                    isLineThrough: false,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextWidget(
                    text: "₹599",
                    color: AppColors().appGreyColor,
                    size: 17,
                    fontWeight: FontWeight.w600,
                    isLineThrough: true,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                    text: "(45 % Off)",
                    color: AppColors().appOrangeColor,
                    size: 17,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: AppColors().appOrangeColor,
                    size: 15,
                  ),
                  TextWidget(
                    text: "4.5 (355 Reviews)",
                    color: AppColors().appGreyColor,
                    size: 14,
                    fontWeight: FontWeight.w500,
                    isLineThrough: false,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLanguageKeys().strText1.tr,
                    maxLines: controller.descTextShowFlag ? 8 : 2,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  InkWell(
                    onTap: () {
                      controller.toggleDescTextShowFlag();
                    },
                    child: Row(
                      children: <Widget>[
                        if (controller.descTextShowFlag)
                          Row(
                            children: <Widget>[
                              Text(
                                AppLanguageKeys().strReadLess.tr,
                                style: TextStyle(
                                  color: AppColors().appPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: AppColors().appPrimaryColor,
                                size: 30,
                              ),
                            ],
                          )
                        else
                          Row(
                            children: <Widget>[
                              Text(
                                AppLanguageKeys().strReadMore.tr,
                                style: TextStyle(
                                  color: AppColors().appPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: AppColors().appPrimaryColor,
                                size: 30,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextWidget(
                text: AppLanguageKeys().strDeliveryAddress.tr,
                color: AppColors().appBlackColor,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
              const SizedBox(
                height: 8,
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
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors().appGreyColor,
                ),
                height: 75,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.fire_truck_sharp,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              TextWidget(
                                text: "Free Delivery   | ",
                                color: AppColors().appPrimaryColor,
                                size: 16,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              TextWidget(
                                text: "    Delivery By",
                                color: AppColors().appBlackColor,
                                size: 16,
                                fontWeight: FontWeight.w600,
                                isLineThrough: false,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextWidget(
                            text: "6th April 2024",
                            color: AppColors().appBlackColor,
                            size: 14,
                            fontWeight: FontWeight.w600,
                            isLineThrough: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: AppLanguageKeys().strSuggested.tr,
                    color: AppColors().appBlackColor,
                    size: 19,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                  TextWidget(
                    text: AppLanguageKeys().strSeeAll.tr,
                    color: AppColors().appBlackColor,
                    size: 15,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(
                    4,
                    (int i) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        width: 140,
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppAssetsImages.product,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: AppLanguageKeys().strHighlights.tr,
                color: AppColors().appBlackColor,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  ConversationList(
                    name: AppLanguageKeys().strHighlight1.tr,
                    messageText: AppLanguageKeys().strHightlightDescription.tr,
                    imageUrl: AppAssetsImages.banner2,
                    isMessageRead: false,
                  ),
                  ConversationList(
                    name: AppLanguageKeys().strHighlight1.tr,
                    messageText: AppLanguageKeys().strHightlightDescription.tr,
                    imageUrl: AppAssetsImages.banner2,
                    isMessageRead: false,
                  ),
                  ConversationList(
                    name: AppLanguageKeys().strHighlight1.tr,
                    messageText: AppLanguageKeys().strHightlightDescription.tr,
                    imageUrl: AppAssetsImages.banner2,
                    isMessageRead: false,
                  ),
                  ConversationList(
                    name: AppLanguageKeys().strHighlight1.tr,
                    messageText: AppLanguageKeys().strHightlightDescription.tr,
                    imageUrl: AppAssetsImages.banner2,
                    isMessageRead: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: AppLanguageKeys().strRatings.tr,
                    color: AppColors().appBlackColor,
                    size: 19,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                  Icon(
                    Icons.edit_calendar_rounded,
                    color: AppColors().appPrimaryColor,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors().appGreyColor,
                ),
                height: 160,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              TextWidget(
                                text: "5",
                                color: AppColors().appBlackColor,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors().appYellowColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 150,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors().appPrimaryColor,
                                    ),
                                    backgroundColor: const Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              TextWidget(
                                text: "4",
                                color: AppColors().appBlackColor,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors().appYellowColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 130,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors().appPrimaryColor,
                                    ),
                                    backgroundColor: const Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              TextWidget(
                                text: "3",
                                color: AppColors().appBlackColor,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors().appYellowColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 100,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors().appPrimaryColor,
                                    ),
                                    backgroundColor: const Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              TextWidget(
                                text: "2",
                                color: AppColors().appBlackColor,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors().appYellowColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 70,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors().appPrimaryColor,
                                    ),
                                    backgroundColor: const Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              TextWidget(
                                text: "1",
                                color: AppColors().appBlackColor,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors().appYellowColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 50,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors().appPrimaryColor,
                                    ),
                                    backgroundColor: const Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          children: <Widget>[
                            TextWidget(
                              text: "4.0",
                              color: AppColors().appBlackColor,
                              size: 30,
                              fontWeight: FontWeight.bold,
                              isLineThrough: false,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: AppColors().appOrangeColor,
                                ),
                                Icon(
                                  Icons.star,
                                  color: AppColors().appOrangeColor,
                                ),
                                Icon(
                                  Icons.star,
                                  color: AppColors().appOrangeColor,
                                ),
                                Icon(
                                  Icons.star,
                                  color: AppColors().appGreyColor,
                                ),
                                Icon(
                                  Icons.star,
                                  color: AppColors().appGreyColor,
                                ),
                              ],
                            ),
                            TextWidget(
                              text: "52 Reviews",
                              color: AppColors().appBlackColor,
                              size: 17,
                              fontWeight: FontWeight.w500,
                              isLineThrough: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff764abc),
                    ),
                    title: Text(
                      AppLanguageKeys().strKrishnaAgarwal.tr,
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: AppColors().appOrangeColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appOrangeColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appOrangeColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appGreyColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appGreyColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text("2 mins ago"),
                      ],
                    ),
                    trailing: const Icon(Icons.more_vert),
                  ),
                  Text(
                    AppLanguageKeys().strText2.tr,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff764abc),
                    ),
                    title: Text(AppLanguageKeys().strKrishnaAgarwal.tr),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: AppColors().appOrangeColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appOrangeColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appOrangeColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appGreyColor,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors().appGreyColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text("2 mins ago"),
                      ],
                    ),
                    trailing: const Icon(Icons.more_vert),
                  ),
                  Text(
                    AppLanguageKeys().strText2.tr,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextWidget(
                        text: AppLanguageKeys().strPrice.tr,
                        color: AppColors().appBlackColor,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      TextWidget(
                        text: "₹199",
                        color: AppColors().appPrimaryColor,
                        size: 20,
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
                      onPressed: () async {
                        await AppNavService().pushNamed(
                          destination: AppRoutes().cartScreen,
                          arguments: <String, dynamic>{},
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLanguageKeys().strAdd.tr.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(
                            CupertinoIcons.arrow_right,
                            size: 22,
                          ),
                        ],
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
