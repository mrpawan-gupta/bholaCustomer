import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HelpScreen extends GetView<HelpController> {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
    );
  }
}
