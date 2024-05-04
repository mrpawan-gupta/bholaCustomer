// ignore_for_file: lines_longer_than_80_chars

import "package:cloud_firestore/cloud_firestore.dart";
import "package:customer/common_functions/cloud_firestore_functions.dart";
import "package:customer/controllers/sample_controllers/firebase_sample_controller.dart";
import "package:customer/utils/app_colors.dart";
import "package:firebase_ui_firestore/firebase_ui_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class FirebaseSampleScreen extends GetView<FirebaseSampleController> {
  const FirebaseSampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Firebase Sample Screen"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: FirestoreListView<dynamic>(
                shrinkWrap: true,
                query: controller.rxQuery.value,
                pageSize: 20,
                itemBuilder: (
                  BuildContext context,
                  QueryDocumentSnapshot<dynamic> docsData,
                ) {
                  final String id = getId(docsData: docsData);
                  final Map<String, dynamic> data = getData(docsData: docsData);

                  final bool containsKey = data.containsKey("name");
                  final String name = containsKey ? data["name"] : "";
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(title: Text(name), subtitle: Text(id)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
