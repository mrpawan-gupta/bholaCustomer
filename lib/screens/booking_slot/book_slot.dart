import "package:customer/controllers/booking_slot_controllers/book_slot_controllers.dart";
import "package:customer/screens/booking_slot/selected_slot.dart";
import "package:customer/screens/home_screen/search.dart";
import "package:customer/screens/widgets/textWidgets.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:syncfusion_flutter_sliders/sliders.dart";



class BookSlot extends GetView<BookSlotController> {
   BookSlot({super.key});

  @override
  final BookSlotController controller = Get.put(BookSlotController());


  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != controller.selectedDate.value) {
      controller.updateSelectedDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Bhola",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              fontSize: 30,
              fontStyle: FontStyle.italic,),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            AppAssetsImages.menu,
            height: 35,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssetsImages.cart,
              height: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssetsImages.notification,
              height: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 80),
        child: Column(
          children: <Widget>[
            SearchTab(
              text: "Farm Location",
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      text: "Schedule",
                      color: Colors.black,
                      size: 19,
                      fontWeight: FontWeight.bold,
                      isLineThrough: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () => selectDate(context),
                      child: Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            width: 3,
                            color: Colors.green,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Please Select a Date",
                              ),
                              Icon(
                                Icons.date_range,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      text: "Crop",
                      color: Colors.black,
                      size: 19,
                      fontWeight: FontWeight.bold,
                      isLineThrough: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: DropdownButton(
                          icon: const Icon(
                            // Add this
                            Icons.arrow_drop_down, // Add this
                            color: Colors.green, // Add this
                          ),
                          underline: Container(),
                          hint: controller.dropDownValue.value == ""
                              ? const Text("Please Select a Crop")
                              : Text(
                            controller.dropDownValue.value,
                            style: const TextStyle(color: Colors.green),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: const TextStyle(color: Colors.green),
                          items: <String>["One", "Two", "Three"].map(
                                (String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (String? val) {
                            controller.dropDownValue.value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                text: "Slot",
                color: Colors.black,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.green,
                    backgroundColor: Colors.green[100],
                    label: const Text("Morning"),
                    selected: controller.value.value == 0,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 0 : -1);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.green,
                    backgroundColor: Colors.green[100],
                    label: const Text("Afternoon"),
                    selected: controller.value.value == 1,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 1 : null);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.green,
                    backgroundColor: Colors.green[100],
                    label: const Text("Evening"),
                    selected: controller.value.value == 2,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 2 : null);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.green,
                    backgroundColor: Colors.green[100],
                    label: const Text("Night"),
                    selected: controller.value.value == 3,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 3 : null);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                text: "Service",
                color: Colors.black,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width / 1.3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.green,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: DropdownButton(
                      icon: const Icon(
                        // Add this
                        Icons.arrow_drop_down, // Add this
                        color: Colors.green, // Add this
                      ),
                      underline: Container(),
                      hint: controller.dropDownValue.value == ""
                          ? const Text("Please Select a Crop")
                          : Text(
                        controller.dropDownValue.value,
                        style: const TextStyle(color: Colors.green),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.green),
                      items: <String>["One", "Two", "Three"].map(
                            (String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (String? val) {
                        controller.updateDropDownValue(val!);
                      },
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                      size: 40,
                    ),),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "Farm Area",
                  color: Colors.black,
                  size: 19,
                  fontWeight: FontWeight.bold,
                  isLineThrough: false,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade400,),
                    height: 30,
                    width: 70,
                    child: const Center(child: Text("15 Acer")),),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.3,
                  child: SfSlider(
                    activeColor: Colors.green,
                    min: 0.0,
                    max: 20.0,
                    value: controller.sliderSel.value,
                    interval: 5,
                    stepSize: 1,

                    showTicks: false,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 5,
                    onChanged: (value) {
                      controller.updateSliderValue(value);
                    },
                  ),
                ),
                Container(
                    height: 50,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                    child: const Center(
                        child: Text("10",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,),),),),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.green),),),),
                  onPressed: () async {
                    await Navigator.of(context, rootNavigator: true)
                        .pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                        const SelectedSlot(),),);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("GET OUOTE".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold,),),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        CupertinoIcons.arrow_right,
                        size: 22,
                      ),
                    ],
                  ),),
            ),
          ],
        ),
      ),
    );
  }
}
