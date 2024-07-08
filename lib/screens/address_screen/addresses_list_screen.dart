import "package:customer/controllers/address_controller/addresses_list_controller.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AddressesListScreen extends GetView<AddressesListController> {
  AddressesListScreen({super.key});

  final List<Map<String, String>> addresses = [
    {
      "title": "Home",
      "address":
      "There are many variations of passages of Lorem Ipsum available There are many variations of passages of Lorem Ipsum available",
      "phone": "7666206574",
    },
    {
      "title": "Pg",
      "address":
      "There are many variations of passages of Lorem Ipsum available",
      "phone": "7666206574",
    },
    {
      "title": "Sunrise",
      "address":
      "There are many variations of passages of Lorem Ipsum available",
      "phone": "7666206574",
    },
    {
      "title": "Office",
      "address":
      "There are many variations of passages of Lorem Ipsum available",
      "phone": "7666206574",
    },
    {
      "title": "Surya",
      "address":
      "There are many variations of passages of Lorem Ipsum available",
      "phone": "7666206574",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Addresses List"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.maps_home_work_outlined, size: 25.0),
                        const SizedBox(width: 10.0),
                        Text(
                          address["title"]!,
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      address["address"]!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Phone number: ${address['phone']}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle edit action
                        },
                        child: const Text(
                          "EDIT",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle delete action
                        },
                        child: const Text(
                          "DELETE",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle share action
                        },
                        child: const Text(
                          "SHARE",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text("ADD NEW ADDRESS"),
        ),
      ),
    );
  }
}
