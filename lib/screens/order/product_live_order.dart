import "package:customer/controllers/order_controllers/product_live_order_controllers.dart";
import "package:customer/screens/widgets/textWidgets.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";


class ProductLivePendingOrder extends GetView<ProductLiveOrderController> {
  const ProductLivePendingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          CupertinoIcons.back,
          size: 30,
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: TextWidget(
          text: AppLanguageKeys().strLivePending.tr,
          color: Colors.black,
          size: 22,
          fontWeight: FontWeight.bold,
          isLineThrough: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    buildContent(
                      userName: AppLanguageKeys().strAshutoshPatil.tr,
                      imagePath: AppAssetsImages.tractor,
                      productName: AppLanguageKeys().strMahindra.tr,
                      address: AppLanguageKeys().strAddress.tr,
                      contact: "8855816942",
                      billAmount: "599" + "/-",
                      date1: "24/01/2024",
                      location1: AppLanguageKeys().strLocation.tr,
                      date2: "26/01/2024",
                      location2: AppLanguageKeys().strlocation2.tr,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF34B72B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child:  Text(
                              AppLanguageKeys().strProgress.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent({
    required String imagePath,
    required String productName,
    required String address,
    required String contact,
    required String billAmount,
    required String date1,
    required String location1,
    required String date2,
    required String location2,
    required String userName,
  }) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),
        Image.asset(
          imagePath,
          width: 323,
          height: 110,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 4),
        Text(
          productName,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,),
        ),
        const SizedBox(height: 10),
        // Name
        buildInfoRow(
          title: AppLanguageKeys().strName.tr,
          value: userName,
          titleColor: const Color(0xFF7A52F4),
          valueColor: Colors.black,
        ),
        const SizedBox(height: 8),
        // Address
        buildInfoRow(
          title: AppLanguageKeys().strAddress1.tr,
          value: address,
          titleColor: const Color(0xFF7A52F4),
          valueColor: Colors.black,
        ),
        const SizedBox(height: 8),
        // Contact
        buildInfoRow(
          title: AppLanguageKeys().strContact.tr,
          value: contact,
          titleColor: const Color(0xFF7A52F4),
          valueColor: Colors.black,
        ),
        const SizedBox(height: 8),
        // Bill/Amount
        buildInfoRow(
          title: AppLanguageKeys().strBillAmount.tr,
          value: billAmount,
          titleColor: const Color(0xFF7A52F4),
          valueColor: Colors.black,
        ),
        const SizedBox(height: 10),
        // Divider
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Dates
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8F60EC),
                    ),
                  ),
                  Text(
                    location1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: Color(0xFF8F60EC),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    date2,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8F60EC),
                    ),
                  ),
                  Text(
                    location2,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Button
      ],
    );
  }

  Widget buildInfoRow({
    required String title,
    required String value,
    required Color titleColor,
    required Color valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: titleColor,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
