

import "dart:async";

import "package:customer/models/banner_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get_state_manager/src/simple/get_controllers.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class ListingScreenController extends GetxController {

  final int pageSize = 6;

  final PagingController<int, Banners> pagingControllerBanners =
  PagingController<int, Banners>(firstPageKey: 0);


  @override
  void onInit() {
    super.onInit();
    pagingControllerBanners.addPageRequestListener(_fetchPageBanners);
  }

  @override
  void onClose() {


    pagingControllerBanners
      ..removePageRequestListener(_fetchPageBanners)
      ..dispose();

    super.onClose();
  }

  Future<void> _fetchPageBanners(int pageKey) async {
    try {
      final List<Banners> newItems = await _apiCallBanners(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerBanners.appendLastPage(newItems)
          : pagingControllerBanners.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerBanners.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Banners>> _apiCallBanners(int pageKey) async {
    final Completer<List<Banners>> completer = Completer<List<Banners>>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "banners",
      query: <String, dynamic>{
        "offset": pageKey,
        "limit": pageSize,
        "appType": "Customer",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        BannerModel model = BannerModel();
        model = BannerModel.fromJson(json);

        completer.complete(model.data?.banners ?? <Banners>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "", message: json["message"]);

        completer.complete(<Banners>[]);
      },
    );
    return completer.future;
  }

}
