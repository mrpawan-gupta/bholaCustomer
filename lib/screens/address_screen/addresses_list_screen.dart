import "package:customer/controllers/address_controller/addresses_list_controller.dart";
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //
            ],
          ),
        ),
      ),
    );
  }
}
