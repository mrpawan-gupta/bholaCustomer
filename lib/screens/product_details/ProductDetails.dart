import "package:customer/controllers/product_detail_page_controllers/product_detail_page_controllers.dart";
import "package:customer/screens/product_details/cart.dart";
import "package:customer/screens/widgets/ConversationListWidgets.dart";
import "package:customer/screens/widgets/textWidgets.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";


class ProductDetailPage extends GetView<ProductDetailPageController> {
  const ProductDetailPage({super.key});


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
                        color: Colors.grey.shade400,),
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
                            color: Colors.white,),
                        child: const Icon(
                          CupertinoIcons.back,
                          size: 20,
                        ),
                      ),),
                  Positioned(
                      top: 165,
                      left: 10,
                      child: Image.asset(
                        AppAssetsImages.back,
                        height: 50,
                        color: Colors.black87,
                      ),),
                  Positioned(
                      top: 15,
                      child: Image.asset(
                        AppAssetsImages.product,
                        height: 400,
                      ),),
                  Positioned(
                      top: 165,
                      right: 10,
                      child: Image.asset(
                        AppAssetsImages.blackright,
                        height: 50,
                        color: Colors.black87,
                      ),),
                  Positioned(
                      bottom: 15,
                      child: Container(
                        height: 70,
                        width: MediaQuery.sizeOf(context).width / 1.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(30), // Image radius
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    child: Image.asset(
                                        AppAssetsImages.product,
                                        fit: BoxFit.cover,),
                                  ),
                                ),
                              ),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(30), // Image radius
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    child: Image.asset(
                                        AppAssetsImages.product,
                                        fit: BoxFit.cover,),
                                  ),
                                ),
                              ),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(30), // Image radius
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    child: Image.asset(
                                        AppAssetsImages.product,
                                        fit: BoxFit.cover,),
                                  ),
                                ),
                              ),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(30), // Image radius
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    child: Image.asset(
                                        AppAssetsImages.product,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(30), // Image radius
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    child: Image.asset(
                                        AppAssetsImages.product,
                                        fit: BoxFit.cover,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextWidget(
                text: "Amul Cattle Feed",
                color: Colors.black,
                size: 22,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
              Row(
                children: [
                  TextWidget(
                    text: "₹199",
                    color: Colors.black,
                    size: 18,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextWidget(
                    text: "MRP",
                    color: Colors.grey,
                    size: 17,
                    fontWeight: FontWeight.w600,
                    isLineThrough: false,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextWidget(
                    text: "₹599",
                    color: Colors.grey,
                    size: 17,
                    fontWeight: FontWeight.w600,
                    isLineThrough: true,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                    text: "(45 % Off)",
                    color: Colors.orange,
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
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 15,
                  ),
                  TextWidget(
                    text: "4.5 (355 Reviews)",
                    color: Colors.grey,
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
                      "In addition to being a major source of starch and energy,"
                          " wheat also provides substantial amounts of a number"
                          " of components which are essential or beneficial for "
                          "health, notably protein, vitamins "
                          "(notably B vitamins), dietary fiber, "
                          "and phytochemicals.",
                      maxLines: controller.descTextShowFlag ? 8 : 2,
                      textAlign: TextAlign.start,),
                  const SizedBox(
                    height: 3,
                  ),
                  InkWell(
                    onTap: () {
                      controller.toggleDescTextShowFlag();
                    },
                    child: Row(
                      children: <Widget>[
                        if (controller.descTextShowFlag) const Row(
                          children: <Widget>[
                            Text(
                              "Read Less",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.green,
                              size: 30,
                            ),
                          ],
                        ) else const Row(
                          children: <Widget>[
                            Text(
                              "Read More",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.green,
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
                text: "Delivery Address",
                color: Colors.black,
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
                              "Apollo Hospital Nashik, Plot No 1, Nashik,"
                                  " Maharashtra 422003, India",
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
                      )
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
                      color: Colors.grey.shade200,),
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
                                  color: Colors.green,
                                  size: 16,
                                  fontWeight: FontWeight.bold,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "    Delivery By",
                                  color: Colors.black,
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
                              color: Colors.black,
                              size: 14,
                              fontWeight: FontWeight.w600,
                              isLineThrough: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Suggested For You",
                    color: Colors.black,
                    size: 19,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                  TextWidget(
                    text: "See All",
                    color: Colors.black,
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
                    children: List.generate(
                      4,
                          (int i) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade200,),
                            width: 140,
                            alignment: Alignment.center,
                            child: Image.asset(
                              AppAssetsImages.product,
                              height: 200,
                              fit: BoxFit.cover,
                            ),),
                      ),
                    ),
                  ),),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: "Highlights",
                color: Colors.black,
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
                      name: "Highlight 1",
                      messageText: "Hightlight description",
                      imageUrl: AppAssetsImages.banner2,
                      isMessageRead: false),
                  ConversationList(
                      name: "Highlight 1",
                      messageText: "Hightlight description",
                      imageUrl: AppAssetsImages.banner2,
                      isMessageRead: false),
                  ConversationList(
                      name: "Highlight 1",
                      messageText: "Hightlight description",
                      imageUrl: AppAssetsImages.banner2,
                      isMessageRead: false),
                  ConversationList(
                      name: "Highlight 1",
                      messageText: "Hightlight description",
                      imageUrl: AppAssetsImages.banner2,
                      isMessageRead: false,),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: "Ratings & Review",
                    color: Colors.black,
                    size: 19,
                    fontWeight: FontWeight.bold,
                    isLineThrough: false,
                  ),
                  const Icon(
                    Icons.edit_calendar_rounded,
                    color: Colors.green,
                    size: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,),
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
                                color: Colors.black,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const SizedBox(
                                width: 150,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green,),
                                    backgroundColor: Color(0xffD6D6D6),
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
                                color: Colors.black,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const SizedBox(
                                width: 130,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green,),
                                    backgroundColor: Color(0xffD6D6D6),
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
                                color: Colors.black,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const SizedBox(
                                width: 100,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green,),
                                    backgroundColor: Color(0xffD6D6D6),
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
                                color: Colors.black,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const SizedBox(
                                width: 70,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green,),
                                    backgroundColor: Color(0xffD6D6D6),
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
                                color: Colors.black,
                                size: 15,
                                fontWeight: FontWeight.bold,
                                isLineThrough: false,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const SizedBox(
                                width: 50,
                                height: 10,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green,),
                                    backgroundColor: Color(0xffD6D6D6),
                                  ),
                                ),
                              )
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
                              color: Colors.black,
                              size: 30,
                              fontWeight: FontWeight.bold,
                              isLineThrough: false,
                            ),
                            const Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            TextWidget(
                              text: "52 Reviews",
                              color: Colors.black,
                              size: 17,
                              fontWeight: FontWeight.w500,
                              isLineThrough: false,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Color(0xff764abc),
                    ),
                    title: Text("Krishna Agarwal"),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("2 mins ago"),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                  Text(
                    "In addition to being a major source of starch and energy, "
                        "wheat also provides substantial amounts of a number of"
                        " components which are essential or beneficial for "
                        "health, notabl, and phytochemicals.",
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 5,),
              const Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Color(0xff764abc),
                    ),
                    title: Text("Krishna Agarwal"),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("2 mins ago"),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                  Text(
                    "In addition to being a major source of starch and energy, "
                        "wheat also provides substantial amounts of a number of"
                        " components which are essential or beneficial for "
                        "health, notabl, and phytochemicals.",
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              const Divider(),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextWidget(
                        text: "Price",
                        color: Colors.black,
                        size: 15,
                        fontWeight: FontWeight.w500,
                        isLineThrough: false,
                      ),
                      TextWidget(
                        text: "₹199",
                        color: Colors.green,
                        size: 20,
                        fontWeight: FontWeight.bold,
                        isLineThrough: false,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width/1.8,
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
                                    side: const BorderSide(color: Colors.green),
                                ),
                            ),
                        ),
                        onPressed: () async {
                          await Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const Cart(),),);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Add to Cart".toUpperCase(),
                                style: const TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.bold,),
                            ),
                            const SizedBox(width: 15,),
                            const Icon(CupertinoIcons.arrow_right,size: 22,),
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
