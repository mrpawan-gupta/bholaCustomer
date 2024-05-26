import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
    );
  }
}
