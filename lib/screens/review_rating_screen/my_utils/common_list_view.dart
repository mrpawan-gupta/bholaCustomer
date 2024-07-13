import "package:customer/common_functions/date_time_functions.dart";
import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/review_rating_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:read_more_text/read_more_text.dart";

class CommonListView extends StatelessWidget {
  const CommonListView({
    required this.pagingController,
    required this.onTap,
    required this.onPressedEdit,
    required this.onPressedDelete,
    required this.type,
    required this.needMoreOptionsButton,
    super.key,
  });

  final PagingController<int, Reviews> pagingController;
  final Function(Reviews item) onTap;
  final Function(Reviews item) onPressedEdit;
  final Function(Reviews item) onPressedDelete;
  final String type;
  final bool needMoreOptionsButton;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Reviews>.separated(
      shrinkWrap: true,
      pagingController: pagingController,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(indent: 16, endIndent: 16);
      },
      builderDelegate: PagedChildBuilderDelegate<Reviews>(
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          return SizedBox(
            height: Get.height / 1.5,
            width: Get.width,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 16),
                  Icon(
                    Icons.star,
                    color: AppColors().appPrimaryColor,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Reviews ratings list is empty!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Check back in a little bit.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: AppTextButton(
                      text: "Try refreshing",
                      onPressed: pagingController.refresh,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
        itemBuilder: (BuildContext context, Reviews item, int index) {
          return reviewsListAdapter(
            item: item,
            onTap: onTap,
            onPressedEdit: onPressedEdit,
            onPressedDelete: onPressedDelete,
            type: type,
            needMoreOptionsButton: needMoreOptionsButton,
          );
        },
      ),
    );
  }
}

Widget reviewsListAdapter({
  required Reviews item,
  required Function(Reviews item) onTap,
  required Function(Reviews item) onPressedEdit,
  required Function(Reviews item) onPressedDelete,
  required String type,
  required bool needMoreOptionsButton,
}) {
  final String customerFirstName = item.customerFirstName ?? "";
  final String customerLastName = item.customerLastName ?? "";

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        leading: SizedBox(
          height: 32,
          width: 32,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CommonImageWidget(
              imageUrl: item.customerProfilePhoto ?? "",
              fit: BoxFit.cover,
              imageType: ImageType.user,
            ),
          ),
        ),
        title: Text(
          "$customerFirstName $customerLastName",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: <Widget>[
            RatingBar.builder(
              ignoreGestures: true,
              allowHalfRating: true,
              initialRating: (item.star ?? 0.0).toDouble(),
              itemSize: 16,
              unratedColor: AppColors().appGrey,
              itemBuilder: (BuildContext context, int index) {
                return Icon(Icons.star, color: AppColors().appOrangeColor);
              },
              onRatingUpdate: (double value) {},
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                formattedDateTime(dateTimeString: item.date ?? ""),
                style: TextStyle(fontSize: 12, color: AppColors().appGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: needMoreOptionsButton
            ? SizedBox(
                height: 24,
                width: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await openMoreOptionsWidget(
                      item: item,
                      onPressedEdit: onPressedEdit,
                      onPressedDelete: onPressedDelete,
                    );
                  },
                  icon: CircleAvatar(
                    backgroundColor: AppColors().appPrimaryColor,
                    child: Icon(
                      Icons.more_horiz,
                      color: AppColors().appWhiteColor,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        onTap: () {
          onTap(item);
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ReadMoreText(
          item.review ?? "",
          numLines: 2,
          readMoreText: "Read more",
          readLessText: "Read less",
          readMoreAlign: Alignment.bottomLeft,
          readMoreIconColor: AppColors().appPrimaryColor,
          readMoreTextStyle: TextStyle(color: AppColors().appPrimaryColor),
        ),
      ),
    ],
  );
}

Future<void> openMoreOptionsWidget({
  required Reviews item,
  required Function(Reviews item) onPressedEdit,
  required Function(Reviews item) onPressedDelete,
}) async {
  await Get.bottomSheet(
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 16),
        Text(
          AppLanguageKeys().strActionPerform.tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ListTile(
          dense: true,
          title: const Text("Edit"),
          trailing: const Icon(Icons.edit),
          onTap: () async {
            AppNavService().pop();

            onPressedEdit(item);
          },
        ),
        ListTile(
          dense: true,
          title: const Text("Delete"),
          trailing: const Icon(Icons.delete),
          onTap: () async {
            AppNavService().pop();

            await openDeleteServiceWidget(
              item: item,
              onPressedDelete: onPressedDelete,
            );
          },
        ),
        const SizedBox(height: 48),
      ],
    ),
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    isScrollControlled: true,
  );
  return Future<void>.value();
}

Future<void> openDeleteServiceWidget({
  required Reviews item,
  required Function(Reviews item) onPressedDelete,
}) async {
  await Get.bottomSheet(
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 16),
        Text(
          AppLanguageKeys().strActionPerform.tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Are you sure you want to delete? It is an irreversible process!",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 50,
                child: AppElevatedButton(
                  text: "Do not delete review",
                  onPressed: () {
                    AppNavService().pop();
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: AppTextButton(
                  text: "Delete review",
                  onPressed: () async {
                    AppNavService().pop();

                    onPressedDelete(item);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 48),
      ],
    ),
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    isScrollControlled: true,
  );
  return Future<void>.value();
}
