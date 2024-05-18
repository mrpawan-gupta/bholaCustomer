import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:customer/services/app_nav_service.dart';
import 'package:customer/utils/app_routes.dart';
import 'package:customer/utils/app_snackbar.dart';
import 'package:customer/utils/app_colors.dart';
import 'package:customer/controllers/outer_main_controllers/booking_slot_controllers/book_slot_controllers.dart';

class BookSlotScreen extends GetView<BookSlotController> {
  const BookSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().appWhiteColor,
      appBar: AppBar(
        title: const Text('Booking Window'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationField(),
            const SizedBox(height: 16.0),
            _buildDateCropFields(context),
            const SizedBox(height: 16.0),
            _buildTimeSlotFields(),
            const SizedBox(height: 16.0),
            _buildServiceField(),
            const SizedBox(height: 16.0),
            _buildFarmAreaSlider(),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  const String scheduleDate = "";
                  const String approxStartTime = "";
                  const String approxEndTime = "";
                  const String crop = "";
                  const String deliveryAddress = "";
                  final List<Map<String, dynamic>> services = [];
                  await createBookingAPICall(
                    scheduleDate: scheduleDate,
                    approxStartTime: approxStartTime,
                    approxEndTime: approxEndTime,
                    crop: crop,
                    deliveryAddress: deliveryAddress,
                    services: services,
                  );
                  await AppNavService().pushNamed(
                    destination: AppRoutes().selectedSlotScreen,
                    arguments: <String, dynamic>{},
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Get Quote'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return DropdownSearch<String>(
      items: ['Farm A', 'Lonavala farm', 'Farm C'],
      // dropdownSearchDecoration: const InputDecoration(
      //   labelText: 'Farm Location',
      //   hintText: 'Enter farm location',
      //   prefixIcon: Icon(Icons.search),
      //   border: OutlineInputBorder(),
      // ),
      onChanged: (value) {
        // Handle location selection
      },
      popupProps: PopupProps.menu(
        showSearchBox: true,
      ),
    );
  }

  Widget _buildDateCropFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => selectDate(context),
            child: AbsorbPointer(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Schedule',
                  hintText: 'Please Select a Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: controller.selectedDate.value.toString().split(' ')[0],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Crop',
              hintText: 'Please Select a Crop',
              border: OutlineInputBorder(),
            ),
            items: ['Crop 1', 'Crop 2', 'Crop 3'].map((String crop) {
              return DropdownMenuItem<String>(
                value: crop,
                child: Text(crop),
              );
            }).toList(),
            onChanged: (newValue) {
              // Handle crop selection
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Start Time',
              hintText: 'Start Time',
              prefixIcon: Icon(Icons.access_time),
              border: OutlineInputBorder(),
            ),
            onTap: () {
              // Handle start time picker
            },
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'End Time',
              hintText: 'End Time',
              prefixIcon: Icon(Icons.access_time),
              border: OutlineInputBorder(),
            ),
            onTap: () {
              // Handle end time picker
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServiceField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Service',
        hintText: 'Please Select a Service',
        border: OutlineInputBorder(),
      ),
      items: ['Service 1', 'Service 2', 'Service 3'].map((String service) {
        return DropdownMenuItem<String>(
          value: service,
          child: Text(service),
        );
      }).toList(),
      onChanged: (newValue) {
        // Handle service selection
      },
    );
  }

  Widget _buildFarmAreaSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Farm Area',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Obx(() => Slider(
          value: controller.sliderSel.value,
          min: 0,
          max: 20,
          divisions: 20,
          label: '${controller.sliderSel.value.toInt()} Acer',
          onChanged: (double value) {
            controller.updateSliderValue(value);
          },
        )),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return Text('${index * 5}');
            }),
          ),
        ),
      ],
    );
  }

  Future<String> createBookingAPICall({
    required String scheduleDate,
    required String approxStartTime,
    required String approxEndTime,
    required String crop,
    required String deliveryAddress,
    required List<Map<String, dynamic>> services,
  }) async {
    final Completer<String> completer = Completer<String>();

    await controller.createBookingAPICall(
      scheduleDate: scheduleDate,
      approxStartTime: approxStartTime,
      approxEndTime: approxEndTime,
      crop: crop,
      deliveryAddress: deliveryAddress,
      services: services,
      successCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarSuccess(
          title: "",
          message: json["message"],
        );
        completer.complete(json["message"]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(
          title: "",
          message: json["message"],
        );
        completer.complete(json["message"]);
      },
    );

    return completer.future;
  }

  void selectDate(BuildContext context) async {
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
}
