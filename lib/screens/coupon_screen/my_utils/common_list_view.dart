import "package:customer/models/coupon_list_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonListView extends StatelessWidget {
  const CommonListView({
    required this.pagingController,
    required this.selectedCoupon,
    required this.onChanged,
    super.key,
  });

  final PagingController<int, Coupons> pagingController;
  final Coupons selectedCoupon;
  final Function(Coupons value) onChanged;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Coupons>.separated(
      shrinkWrap: true,
      pagingController: pagingController,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(indent: 16, endIndent: 16);
      },
      builderDelegate: PagedChildBuilderDelegate<Coupons>(
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          return const SizedBox();
        },
        itemBuilder: (BuildContext context, Coupons item, int index) {
          return couponsListAdapter(
            item: item,
            selectedCoupon: selectedCoupon,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}

Widget couponsListAdapter({
  required Coupons item,
  required Coupons selectedCoupon,
  required Function(Coupons value) onChanged,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      RadioListTile<Coupons>(
        dense: true,
        value: item,
        groupValue: selectedCoupon,
        activeColor: AppColors().appPrimaryColor,
        toggleable: true,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(
          item.code ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Discount percent:",
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${item.discountPercent ?? 0}%",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Max amount:",
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "₹${item.maxamount ?? 0}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onChanged: (Coupons? value) {
          if (value != null) {
            onChanged(value);
          } else {}
        },
      ),
    ],
  );
}
