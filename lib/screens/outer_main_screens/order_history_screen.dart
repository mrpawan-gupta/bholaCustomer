import "package:customer/controllers/outer_main_controllers/order_history_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class OrderHistoryScreen extends GetView<OrderHistoryController> {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
    );
  }
}
