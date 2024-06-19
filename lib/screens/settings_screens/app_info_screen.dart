import "package:customer/controllers/settings_controllers/app_info_controller.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

class AppInfoScreen extends GetView<AppInfoController> {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("App Info"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  customListTile(
                    title: "Application name",
                    value: controller.rxPackageInfo.value.appName,
                  ),
                  customListTile(
                    title: "Package name",
                    value: controller.rxPackageInfo.value.packageName,
                  ),
                  customListTile(
                    title: "Build version",
                    value: controller.rxPackageInfo.value.version,
                  ),
                  customListTile(
                    title: "Build number",
                    value: controller.rxPackageInfo.value.buildNumber,
                  ),
                  customListTile(
                    title: "Build signature",
                    value: controller.rxPackageInfo.value.buildSignature,
                  ),
                  customListTile(
                    title: "Installer Store",
                    value: controller.rxPackageInfo.value.installerStore ?? "",
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget customListTile({required String title, required String value}) {
    return ListTile(
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () async {
          await Clipboard.setData(
            ClipboardData(text: value),
          );

          AppSnackbar().snackbarSuccess(
            title: "Yay!",
            message: "Copied to clipboard!",
          );
        },
      ),
      onTap: () {},
    );
  }
}
