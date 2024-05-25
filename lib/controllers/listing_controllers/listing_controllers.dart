import "dart:async";
import "package:customer/models/banner_model.dart";
import "package:customer/models/list_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get_state_manager/src/simple/get_controllers.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class ListingScreenController extends GetxController {

  final int pageSize = 6;

  final PagingController<int, Banners> pagingControllerBanners =
  PagingController<int, Banners>(firstPageKey: 1);

  final PagingController<int, Lists> pagingControllerProducts =
  PagingController<int, Lists>(firstPageKey: 1);


  @override
  void onInit() {
    super.onInit();
    pagingControllerBanners.addPageRequestListener(_fetchPageBanners);
    pagingControllerProducts.addPageRequestListener(_fetchPageRecently);
  }

  @override
  void onClose() {


    pagingControllerBanners
      ..removePageRequestListener(_fetchPageBanners)
      ..dispose();

    pagingControllerProducts
      ..removePageRequestListener(_fetchPageRecently)
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

  Future<void> _fetchPageRecently(int pageKey) async {
    try {
      final List<Lists> newItems = await _apiCallRecently(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerProducts.appendLastPage(newItems)
          : pagingControllerProducts.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerProducts.error = error;
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

  Future<List<Lists>> _apiCallRecently(int pageKey) async {
    final Completer<List<Lists>> completer = Completer<List<Lists>>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": 10,
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        ListModel model = ListModel();
        model = ListModel.fromJson(json);

        final List<Lists> temp = <Lists>[
          ...model.data?.products ?? <Lists>[],
          ...<Lists>[Lists()],
        ];

        completer.complete(temp);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "", message: json["message"]);

        completer.complete(<Lists>[]);
      },
    );
    return completer.future;
  }

}
