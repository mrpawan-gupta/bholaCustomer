// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/controllers/address_controller/addresses_list_controller.dart";
import "package:customer/models/get_addresses_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:place_picker/place_picker.dart";
import "package:read_more_text/read_more_text.dart";

class AddressesListScreen extends GetView<AddressesListController> {
  const AddressesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Addresses List"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                noteWidget(),
                const SizedBox(height: 16),
                Expanded(child: SingleChildScrollView(child: listView())),
                const SizedBox(height: 16),
                button(),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget noteWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Tap on any address to make it as your primary address.",
            style: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.rxAddressList.length,
      padding: EdgeInsets.zero,
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 0, indent: 64, endIndent: 64);
      },
      itemBuilder: (BuildContext context, int index) {
        final Address item = controller.rxAddressList[index];
        return listAdapter(item);
      },
    );
  }

  Widget listAdapter(Address item) {
    return InkWell(
      onTap: () async {
        await controller.updateAddressesAPI(id: item.sId ?? "");
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  await controller.updateAddressesAPI(id: item.sId ?? "");
                },
                icon: Icon(
                  (item.isPrimary ?? false)
                      ? Icons.home_outlined
                      : Icons.location_on_outlined,
                  color: (item.isPrimary ?? false)
                      ? AppColors().appPrimaryColor
                      : AppColors().appBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  (item.isPrimary ?? false) ? "Primary" : "Other",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (item.isPrimary ?? false)
                        ? AppColors().appPrimaryColor
                        : AppColors().appBlackColor,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                ReadMoreText(
                  "${item.street ?? ""} ${item.city ?? ""} ${item.country ?? ""} ${item.pinCode ?? ""}",
                  numLines: 2,
                  readMoreText: "Read more",
                  readLessText: "Read less",
                  readMoreAlign: Alignment.bottomLeft,
                  readMoreIconColor: AppColors().appGreyColor,
                  readMoreTextStyle: TextStyle(color: AppColors().appGreyColor),
                  style: TextStyle(
                    color: (item.isPrimary ?? false)
                        ? AppColors().appPrimaryColor
                        : AppColors().appBlackColor,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  await controller.deleteAddressesAPI(id: item.sId ?? "");
                },
                icon:
                    Icon(Icons.delete_outline, color: AppColors().appRedColor),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
            width: double.infinity,
            child: AppElevatedButton(
              text: "Add a new address from maps",
              onPressed: showPlacePicker,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showPlacePicker() async {
    final PlacePicker route = PlacePicker(AppConstants().googleMapAPIKey);

    final dynamic result = await Navigator.of(Get.context!).push(
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => route),
    );

    if (result != null && result is LocationResult) {
      final String reason = controller.validateLocationResult(result: result);
      if (reason.isEmpty) {
        await controller.setAddressesAPI(result: result);
      } else {
        AppSnackbar().snackbarFailure(title: "Oops", message: reason);
      }
    } else {}
    return Future<void>.value();
  }
}
