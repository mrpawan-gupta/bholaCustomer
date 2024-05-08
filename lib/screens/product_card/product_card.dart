import "dart:ui";
import "package:customer/controllers/product_card_controllers/product_card_controllers.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";

class ProductCard extends GetView<ProductCardController> {

  ProductCard(
      {required this.productName, required this.productImage,
        required this.height,
        required this.width, required this.price, super.key,});
  String productName;
  String productImage;
  String price;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors().appWhiteColor,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 2,
            color: Color(0x520E151B),
            offset: Offset(
              0.0,
              1,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 300,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                productImage,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xB2FFFFFF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  productName,
                                  style: const TextStyle(
                                    color: Color(0xFF0F1113),
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "₹$price/-",
                                  style: const TextStyle(
                                    color: Color(0xFF0F1113),
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
