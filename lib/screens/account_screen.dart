// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/controllers/account_controller.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get/state_manager.dart";

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text("This value will update"),
            Obx(
              () {
                /* 
                  This Text Widget is wrapped with Obx. The Obx builder constantly listens for changes in its child 
                  and updates accordingly. Specifically, Obx observes changes in the controller's counter variable.
                */
                return Text(controller.counter.value.toString());
              },
            ),

            /* 
               This Text Widget isn't wrapped with Obx, so its value won't change. 
               Even if the variable is updated in the background, the UI won't reflect it 
               because there's no Obx Builder to handle the updates.
            */
            const Text("This value will not update"),
            Text(controller.counter.value.toString()),

            const SizedBox(height: 32),
            
            AppElevatedButton(
              text: "increment",
              onPressed: controller.increment,
            ),
            AppElevatedButton(
              text: "decrement",
              onPressed: controller.decrement,
            ),
          ],
        ),
      ),
    );
  }
}
