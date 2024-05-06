import "package:customer/controllers/product_detail_page_controllers/cart_controllers.dart";
import "package:customer/screens/widgets/Checkout.dart";
import "package:customer/screens/widgets/textWidgets.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";



class Cart extends GetView<CartController> {
  const Cart({super.key});

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
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
          text: "Shopping Bag",
          color: Colors.black,
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade100,),
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
                                child: Image.asset(AppAssetsImages.tractor,
                                    fit: BoxFit.fitHeight,),
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
                                      text: "Tractor",
                                      color: Colors.green,
                                      size: 16,
                                      fontWeight: FontWeight.bold,
                                      isLineThrough: false,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                      text: "Farm Tool",
                                      color: Colors.black,
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                      isLineThrough: false,
                                    ),
                                  ],
                                ),
                                TextWidget(
                                  text: "₹1000",
                                  color: Colors.black,
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
                              color: Colors.green,),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 16,
                                  ),),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 3,),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2,),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white,),
                                child: const Text(
                                  "3",
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                                ),
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  ),),
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
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade100,),
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
                              child: Image.asset(AppAssetsImages.tractor,
                                  fit: BoxFit.fitHeight,),
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
                                    text: "Tractor",
                                    color: Colors.green,
                                    size: 16,
                                    fontWeight: FontWeight.bold,
                                    isLineThrough: false,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextWidget(
                                    text: "Farm Tool",
                                    color: Colors.black,
                                    size: 14,
                                    fontWeight: FontWeight.w400,
                                    isLineThrough: false,
                                  ),
                                ],
                              ),
                              TextWidget(
                                text: "₹1000",
                                color: Colors.black,
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
                            color: Colors.green,),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 16,
                                ),),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 2,),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white,),
                              child: const Text(
                                "3",
                                style:
                                TextStyle(color: Colors.black, fontSize: 22),
                              ),
                            ),
                            InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),),
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
                text: "Delivery Address",
                color: Colors.black,
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
                    color: Colors.grey.shade200,),
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
                            text: "Rohan Patil",
                            color: Colors.black,
                            size: 16,
                            fontWeight: FontWeight.bold,
                            isLineThrough: false,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.4,
                            child: const Text(
                              "Apollo Hospital Nashik, Plot No 1, Nashik, "
                                  "Maharashtra 422003, India",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.edit_calendar_rounded,
                        color: Colors.green,
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
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,),
                height: 40,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Apply Coupon Code"),
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
                    child: const Divider(),),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: "Order Payment Details",
                color: Colors.black,
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
                        text: "Order Amount",
                        color: Colors.black,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      const SizedBox(height: 6,),
                      Row(
                        children: <Widget>[
                          TextWidget(
                            text: "Convenience",
                            color: Colors.black,
                            size: 15,
                            fontWeight: FontWeight.w500,
                            isLineThrough: false,
                          ),
                          TextWidget(
                            text: "     Know More",
                            color: Colors.green,
                            size: 13,
                            fontWeight: FontWeight.w500,
                            isLineThrough: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6,),
                      TextWidget(
                        text: "Delivery Fee",
                        color: Colors.black,
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
                        color: Colors.black,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      const SizedBox(height: 6,),
                      TextWidget(
                        text: "Apply Coupon",
                        color: Colors.green,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      const SizedBox(height: 6,),
                      TextWidget(
                        text: "Free",
                        color: Colors.green,
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
                    child: const Divider(),),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: "Order Total",
                    color: Colors.black,
                    size: 16,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),TextWidget(
                    text: "₹ 7000",
                    color: Colors.black,
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
                        color: Colors.black,
                        size: 16,
                        fontWeight: FontWeight.bold,
                        isLineThrough: false,
                      ),
                      TextWidget(
                        text: "View Details",
                        color: Colors.black,
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
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.green,),),),),
                        onPressed: () async {
                          await Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const Checkout(),),);
                        },
                        child: Text("Proceed T0 Payment".toUpperCase(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold,),),),
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
