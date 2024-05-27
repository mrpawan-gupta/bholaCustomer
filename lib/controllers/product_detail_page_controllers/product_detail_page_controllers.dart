import "dart:async";

import "package:customer/models/product_details_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";
import "package:pod_player/pod_player.dart";

class ProductDetailController extends GetxController {

  final RxString rxProductId = "".obs;
  final RxInt rxCurrentIndex = 0.obs;
  final Rx<ProductDetailsData> rxProductDetailsData = ProductDetailsData().obs;
  final RxBool descTextShowFlag = false.obs;
  final RxString productPhoto = "".obs;


  PodPlayerController podPlayerController = PodPlayerController(
    playVideoFrom: PlayVideoFrom.network(""),
  );

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateProductId(arguments["id"]);
      } else {}
    } else {}

    unawaited(getProductDetailsAPICall());
  }

  void toggleDescTextShowFlag() {
    descTextShowFlag.value = !descTextShowFlag.value;
  }

  void updateProductId(String value) {
    rxProductId(value);
    return;
  }

  Future<void> initPodPlayerController() async {
    final String videoURL = rxProductDetailsData.value.video ?? "";
    if (videoURL.isNotEmpty) {
      podPlayerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(videoURL),
      );
      await podPlayerController.initialise();
    } else {}
  }

  @override
  void onClose() {
    podPlayerController.dispose();

    super.onClose();
  }

  void updateCurrentIndex(int value) {
    rxCurrentIndex(value);
    return;
  }

  void updateProductDetailsData(ProductDetailsData value) {
    rxProductDetailsData(value);
    productPhoto(value.photo ?? "");
    return;
  }


  Future<void> getProductDetailsAPICall() async {
    final Completer<void> completer = Completer<void>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product/${rxProductId.value}",
      successCallback: (Map<String, dynamic> json) async {
        AppLogger().info(message: json["message"]);

        ProductDetails productDetails = ProductDetails();
        productDetails = ProductDetails.fromJson(json);

        updateProductDetailsData(productDetails.data ?? ProductDetailsData());

        await initPodPlayerController();

        completer.complete();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete();
      },
    );
    return completer.future;
  }



}
