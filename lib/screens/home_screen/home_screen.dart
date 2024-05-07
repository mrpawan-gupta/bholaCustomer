import "package:customer/controllers/home_screen_controllers/home_screen_controllers.dart";
import "package:customer/screens/home_screen/search.dart";
import "package:customer/screens/product_card/product_card.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";



class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (HomeScreenController controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title:  Text(
              AppLanguageKeys().strBhola.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppAssetsImages.menu,
                height: 35,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  AppAssetsImages.cart,
                  height: 28,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  AppAssetsImages.notification,
                  height: 28,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SearchTab(
                    text: AppLanguageKeys().strSearch.tr,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Service",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 110,
                        height: 110,
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () async {
                              await AppNavService().pushNamed(
                                destination: AppRoutes().productDetailScreen,
                                arguments: <String, dynamic>{},
                              );
                            },
                            child: GridTile(
                              footer: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                //color: Colors.blue.withOpacity(.5),
                                child:  Text(
                                  AppLanguageKeys().strTractor.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                AppAssetsImages.tractor,
                                color: Colors.green.withOpacity(0.8),
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {},
                            child: GridTile(
                              footer: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child:  Text(
                                  AppLanguageKeys().strDrone.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                AppAssetsImages.drone,
                                color: Colors.green.withOpacity(0.9),
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {},
                            child: GridTile(
                              footer: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child:  Text(
                                  AppLanguageKeys().strJCB.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                AppAssetsImages.jcb,
                                color: Colors.green.withOpacity(0.8),
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),),
                      child: ColoredBox(
                        color: Colors.green.withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                   Row(
                                    children: <Widget>[
                                      const Icon(
                                        CupertinoIcons.location_solid,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(
                                        AppLanguageKeys().
                                        strNashik_India.tr,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11,),
                                      ),
                                    ],
                                  ),
                                   Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                    child: Text(
                                      AppLanguageKeys().strFriday.tr,
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.white,),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                    child: Row(
                                      children: <Widget>[
                                         Text(
                                          AppLanguageKeys().strDegree.tr,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,),
                                        ),
                                        Image.asset(
                                          AppAssetsImages.rainy_2d,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: <Widget>[
                                   Text(
                                    AppLanguageKeys().strSAT.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,),
                                  ),
                                   Text(
                                    AppLanguageKeys().strDegree1.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Image.asset(
                                    AppAssetsImages.sunny_2d,
                                    height: 21,
                                    width: 21,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                   Text(
                                    AppLanguageKeys().strSUN.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,),
                                  ),
                                   Text(
                                    AppLanguageKeys().strDegree2.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Image.asset(
                                    AppAssetsImages.thunder_2d,
                                    height: 21,
                                    width: 21,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                   Text(
                                    AppLanguageKeys().strMON.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,),
                                  ),
                                   Text(
                                    AppLanguageKeys().strDegree3.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Image.asset(
                                    AppAssetsImages.sunny_2d,
                                    height: 21,
                                    width: 21,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                   Text(
                                    AppLanguageKeys().strTUE.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,),
                                  ),
                                   Text(
                                    AppLanguageKeys().strDegree3.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Image.asset(
                                    AppAssetsImages.rainy_2d,
                                    height: 21,
                                    width: 21,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                   Text(
                                    AppLanguageKeys().strWED.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,),
                                  ),
                                   Text(
                                    AppLanguageKeys().strDegree3.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Image.asset(
                                    AppAssetsImages.sunny_2d,
                                    height: 21,
                                    width: 21,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                   Text(
                                    AppLanguageKeys().strTHU.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,),
                                  ),
                                   Text(
                                    AppLanguageKeys().strDegree5.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Image.asset(
                                    AppAssetsImages.thunder_2d,
                                    height: 21,
                                    width: 21,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    AppLanguageKeys().strProduct.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 110,
                        height: 110,
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {},
                            child: GridTile(
                              footer: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.fromLTRB(8, 10, 8, 5),
                                child:  Text(
                                  AppLanguageKeys().strCattle_Feed.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                AppAssetsImages.cattle,
                                color: Colors.green.withOpacity(0.5),
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {},
                            child: GridTile(
                              footer: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.fromLTRB(8, 10, 8, 5),
                                //color: Colors.blue.withOpacity(.5),
                                child:  Text(
                                  AppLanguageKeys().strNursery.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                AppAssetsImages.cattle,
                                color: Colors.green.withOpacity(0.5),
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {},
                            child: GridTile(
                              footer: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.fromLTRB(8, 10, 8, 5),
                                child:  Text(
                                  AppLanguageKeys().strFertilizer.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                AppAssetsImages.cattle,
                                color: Colors.green.withOpacity(0.5),
                                colorBlendMode: BlendMode.modulate,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),),
                    child: Image.asset(AppAssetsImages.banner2),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLanguageKeys().strCattle_Feed.tr,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,),
                      ),
                       Row(
                        children: <Widget>[
                          Text(
                            AppLanguageKeys().strView_All.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.green,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      ProductCard(
                        height: 150,
                        width: 150,
                        price: "500",
                        productName: AppLanguageKeys().strBajra.tr,
                        productImage: AppAssetsImages.wheat,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ProductCard(
                        height: 150,
                        width: 150,
                        price: "500",
                        productName: AppLanguageKeys().strBajra.tr,
                        productImage: AppAssetsImages.tractor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLanguageKeys().strFertilizer.tr,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            AppLanguageKeys().strView_All.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.green,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      ProductCard(
                        height: 150,
                        width: 150,
                        price: "500",
                        productName: AppLanguageKeys().strBajra.tr,
                        productImage: AppAssetsImages.wheat,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ProductCard(
                        height: 150,
                        width: 150,
                        price: "500",
                        productName: AppLanguageKeys().strBajra.tr,
                        productImage: AppAssetsImages.tractor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
