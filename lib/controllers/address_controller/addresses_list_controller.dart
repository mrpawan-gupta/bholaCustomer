import "dart:async";

import "package:customer/models/get_addresses_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";

class AddressesListController extends GetxController {
  final RxList<Address> rxAddressInfo = <Address>[].obs;

  @override
  void onInit() {
    super.onInit();

    unawaited(getAddressesAPI());
  }

  void updateAddressInfo(List<Address> value) {
    rxAddressInfo(value);
    return;
  }

  Future<void> getAddressesAPI() async {
    await AppAPIService().functionGet(
      types: Types.oauth,
      endPoint: "address/0",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAddresses model = GetAddresses();
        model = GetAddresses.fromJson(json);

        updateAddressInfo(model.data?.address ?? <Address>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );
    return Future<void>.value();
  }
}
