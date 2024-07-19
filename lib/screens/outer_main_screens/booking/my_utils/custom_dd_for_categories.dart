import "package:customer/models/featured_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:dropdown_search/dropdown_search.dart";
import "package:flutter/material.dart";

class CustomDDForCategories extends StatelessWidget {
  const CustomDDForCategories({
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final Categories? selectedItem;
  final List<Categories> items;
  final Function(Categories? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Categories>(
      selectedItem: selectedItem,
      items: items,
      itemAsString: (Categories item) {
        return item.name ?? "";
      },
      onChanged: onChanged,
      dropdownButtonProps: DropdownButtonProps(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors().appPrimaryColor,
          size: 24,
        ),
        padding: EdgeInsets.zero,
      ),
      popupProps: const PopupProps<Categories>.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        searchDelay: Duration.zero,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "Select",
          hintStyle: TextStyle(fontSize: 14, color: AppColors().appGreyColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
