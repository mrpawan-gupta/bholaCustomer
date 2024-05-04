// ignore_for_file: lines_longer_than_80_chars

import "package:customer/controllers/settings_controllers/change_language_controller.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ChangeLanguageScreen extends GetView<ChangeLanguageController> {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Change Language"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Obx(
                () {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.rxAllAppLocalsLength.value,
                    itemBuilder: (BuildContext context, int index) {
                      final Locale locale = controller.getItemFromIndex(index);
                      return RadioListTile<Locale>(
                        title: Text(controller.getDisplayString(locale)),
                        value: locale,
                        groupValue: controller.rxSelectedLocal.value,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (Locale? newLocale) async {
                          if (newLocale != null) {
                            controller.updateLocale(newLocale);
                            await controller.setUserLangToStorage();
                            await Get.updateLocale(newLocale);
                          } else {}
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
