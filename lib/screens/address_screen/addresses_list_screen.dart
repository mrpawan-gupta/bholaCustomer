// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/controllers/address_controller/addresses_list_controller.dart";
import "package:customer/models/get_addresses_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: SingleChildScrollView(child: listView())),
            const SizedBox(height: 16),
            button(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.rxAddressInfo.length,
      padding: EdgeInsets.zero,
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(indent: 54, endIndent: 56);
      },
      itemBuilder: (BuildContext context, int index) {
        final Address item = controller.rxAddressInfo[index];
        return listAdapter(item);
      },
    );
  }

  Widget listAdapter(Address item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              (item.isPrimary ?? false)
                  ? Icons.home_outlined
                  : Icons.location_on_outlined,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                (item.isPrimary ?? false) ? "Primary" : "Other",
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                "${item.street ?? ""} ${item.city ?? ""} ${item.country ?? ""} ${item.pinCode ?? ""}",
                style: TextStyle(color: AppColors().appGrey),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                    width: 54,
                    child: AppTextButton(text: "Edit", onPressed: () {}),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 24,
                    width: 54,
                    child: AppTextButton(text: "Delete", onPressed: () {}),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 24,
                    width: 54,
                    child: AppTextButton(text: "Share", onPressed: () {}),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(width: 16),
      ],
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
              text: "Add new address",
              onPressed: () async {},
            ),
          ),
        ],
      ),
    );
  }
}
