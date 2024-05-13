import "package:customer/controllers/splash_screen_controller/onboard_screen_controller.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class OnBoardScreen extends GetView<OnBoardScreenController> {
  OnBoardScreen({super.key});

  final List<Map<String, dynamic>> _slides = <Map<String, dynamic>>[
    {
      "image": AppAssetsImages.onboard1,
    },
    {
      "image": AppAssetsImages.onboard2,
    },
    {
      "image": AppAssetsImages.onboard3,
    },
  ];

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Expanded(
              child: PageView.builder(
                allowImplicitScrolling: true,
                itemCount: _slides.length,
                controller: _pageController,
                onPageChanged: (int value) {
                  controller.currentPage;
                },
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    _slides[index]["image"],
                    width: 100,
                    height: 80,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _slides.length; i++)
                  if (i == controller.currentPage)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors().appWhiteColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors().appGreyColor,
                        shape: BoxShape.circle,
                      ),
                    ),
              ],
            ),
            const SizedBox(
              height: 130,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      AppColors().appWhiteColor,
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors().appOrangeColor,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: AppColors().appOrangeColor,
                          )),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (_, __, ___) => Phone(),
                    //     transitionDuration: Duration(seconds: 2),
                    //     transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    //   ),
                    // );
                  },
                  child: Text(AppLanguageKeys().strContinue.tr,
                      style: const TextStyle(fontSize: 14))),
            ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: AppLanguageKeys().strProceeding.tr,
                    style: TextStyle(
                      color: AppColors().appWhiteColor,
                    ),
                  ),
                  TextSpan(
                    text: AppLanguageKeys().strCondition.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors().appOrangeColor,
                    ),
                  ),
                  TextSpan(
                    text: AppLanguageKeys().strAnd.tr,
                    style: TextStyle(
                      color: AppColors().appWhiteColor,
                    ),
                  ),
                  TextSpan(
                    text: AppLanguageKeys().strPrivacyPolicy.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors().appOrangeColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLanguageKeys().strBuild.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF8E93F1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
