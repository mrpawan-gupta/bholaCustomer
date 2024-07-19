import "package:customer/models/get_all_services.dart";
import "package:customer/utils/app_colors.dart";
import "package:dropdown_search/dropdown_search.dart";
import "package:flutter/material.dart";

class CustomDDForServices extends StatelessWidget {
  const CustomDDForServices({
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final Services? selectedItem;
  final List<Services> items;
  final Function(Services? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Services>(
      selectedItem: selectedItem,
      items: items,
      itemAsString: (Services item) {
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
      popupProps: const PopupProps<Services>.menu(
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
