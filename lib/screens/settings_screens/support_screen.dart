// ignore_for_file: lines_longer_than_80_chars

import "package:customer/controllers/settings_controllers/support_controller.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_url_launcher.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Support"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Connect with Us",
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Choose your preferred support channel effortlessly with our intuitive UI. Connect via WhatsApp, Phone, SMS, or Email for quick assistance.",
                ),
              ),
              const SizedBox(height: 16),
              customListTile(
                title: "WhatsApp",
                value: AppConstants().whatsAppNumber,
                iconData: Icons.wechat,
                onTapOrPressed: AppWhatsApp().openWhatsApp,
              ),
              customListTile(
                title: "Phone",
                value: AppConstants().whatsAppNumber,
                iconData: Icons.call,
                onTapOrPressed: () async {
                  await AppURLLauncher().open(
                    scheme: "tel",
                    path: AppConstants().whatsAppNumber,
                  );
                },
              ),
              customListTile(
                title: "SMS",
                value: AppConstants().whatsAppNumber,
                iconData: Icons.sms,
                onTapOrPressed: () async {
                  await AppURLLauncher().open(
                    scheme: "sms",
                    path: AppConstants().whatsAppNumber,
                  );
                },
              ),
              customListTile(
                title: "Email",
                value: "krishna@bhola.org.in",
                iconData: Icons.email,
                onTapOrPressed: () async {
                  await AppURLLauncher().open(
                    scheme: "mailto",
                    path: "krishna@bhola.org.in",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile({
    required String title,
    required String value,
    required IconData iconData,
    required Function() onTapOrPressed,
  }) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        value,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_circle_right_outlined),
        onPressed: onTapOrPressed,
      ),
      onTap: onTapOrPressed,
    );
  }
}
