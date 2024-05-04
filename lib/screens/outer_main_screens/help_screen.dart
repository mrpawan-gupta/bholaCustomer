import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HelpScreen extends GetView<HelpController> {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    title: Text("$index"),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
