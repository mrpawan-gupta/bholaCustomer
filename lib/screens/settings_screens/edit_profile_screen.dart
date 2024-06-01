import "dart:io";

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/settings_controllers/edit_profile_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_image_video_picker.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:transparent_image/transparent_image.dart";

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        radius: 64,
                        borderRadius: BorderRadius.circular(100),
                        onTap: () async {
                          await AppImageVideoPicker().openImageVideoPicker(
                            filePathCallback:
                                controller.updateProfilePicturePath,
                            isForVideo: false,
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            userImage(),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Card(
                                surfaceTintColor: AppColors().appWhiteColor,
                                shape: const OvalBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors().appPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () async {},
                          child: Text(
                            "${AppLanguageKeys().strFirstName.tr}*",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors().appGreyColor.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(width: 16 + 8),
                              Expanded(
                                child: AppTextField(
                                  controller: controller.firstNameController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  readOnly: false,
                                  obscureText: false,
                                  maxLines: 1,
                                  maxLength: null,
                                  onChanged: controller.updateFirstName,
                                  onTap: () {},
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter
                                        .singleLineFormatter,
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]"),
                                    ),
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"),
                                    ),
                                  ],
                                  enabled: true,
                                  autofillHints: const <String>[
                                    AutofillHints.givenName,
                                  ],
                                  hintText: "Pawan",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors().appGreyColor,
                                  ),
                                  prefixIcon: null,
                                  suffixIcon: null,
                                ),
                              ),
                              const SizedBox(width: 16 + 8),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () async {},
                          child: Text(
                            "${AppLanguageKeys().strLastName.tr}*",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors().appGreyColor.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(width: 16 + 8),
                              Expanded(
                                child: AppTextField(
                                  controller: controller.lastNameController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  readOnly: false,
                                  obscureText: false,
                                  maxLines: 1,
                                  maxLength: null,
                                  onChanged: controller.updateLastName,
                                  onTap: () {},
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter
                                        .singleLineFormatter,
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]"),
                                    ),
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"),
                                    ),
                                  ],
                                  enabled: true,
                                  autofillHints: const <String>[
                                    AutofillHints.familyName,
                                  ],
                                  hintText: "Gupta",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors().appGreyColor,
                                  ),
                                  prefixIcon: null,
                                  suffixIcon: null,
                                ),
                              ),
                              const SizedBox(width: 16 + 8),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () async {},
                          child: Text(
                            // ignore: lines_longer_than_80_chars
                            "${AppLanguageKeys().strEmail.tr} (${AppLanguageKeys().strOptional.tr})",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors().appGreyColor.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(width: 16 + 8),
                              Expanded(
                                child: AppTextField(
                                  controller: controller.emailAddressController,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  textInputAction: TextInputAction.done,
                                  readOnly: false,
                                  obscureText: false,
                                  maxLines: 1,
                                  maxLength: null,
                                  onChanged: controller.updateEmailAddress,
                                  onTap: () {},
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter
                                        .singleLineFormatter,
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"),
                                    ),
                                  ],
                                  enabled: true,
                                  autofillHints: const <String>[
                                    AutofillHints.email,
                                  ],
                                  hintText: "pawangupta@yopmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors().appGreyColor,
                                  ),
                                  prefixIcon: null,
                                  suffixIcon: null,
                                ),
                              ),
                              const SizedBox(width: 16 + 8),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AppElevatedButton(
                text: AppLanguageKeys().strContinue.tr,
                onPressed: () async {
                  final String reason = controller.validateForm();
                  if (reason.isEmpty) {
                    final bool value = await controller.confirmSaveProcedure();
                    if (value) {
                      AppNavService().pop();
                    } else {}
                  } else {
                    AppSnackbar().snackbarFailure(
                      title: "Oops",
                      message: reason,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget userImage() {
    return Obx(
      () {
        final bool condition1 = controller.rxProfilePictureURLs.value.isEmpty;
        final bool condition2 = controller.rxProfilePicturePath.value.isEmpty;
        return CircleAvatar(
          radius: 64,
          foregroundImage: condition1 && condition2
              ? AssetImage(
                  AppAssetsImages().userPlaceholder,
                ) as ImageProvider
              : !condition1 && condition2
                  ? NetworkImage(
                      controller.rxProfilePictureURLs.value,
                    ) as ImageProvider
                  : condition1 && !condition2
                      ? FileImage(
                          File(
                            controller.rxProfilePicturePath.value,
                          ),
                        ) as ImageProvider
                      : MemoryImage(
                          kTransparentImage,
                        ) as ImageProvider,
        );
      },
    );
  }
}
