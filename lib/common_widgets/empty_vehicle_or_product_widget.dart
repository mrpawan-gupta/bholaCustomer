import "package:customer/utils/app_colors.dart";
import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";


class EmptyVehicleOrProductWidget extends StatelessWidget {
  const EmptyVehicleOrProductWidget({
    required this.text,
    required this.onTap,
    super.key,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12.0),
          color: AppColors().appPrimaryColor,
          dashPattern: const <double>[8],
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 64 - 32,
                  backgroundColor:
                      AppColors().appPrimaryColor.withOpacity(0.10),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors().appPrimaryColor,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors().appBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
