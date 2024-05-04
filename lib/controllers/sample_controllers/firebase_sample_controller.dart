import "package:cloud_firestore/cloud_firestore.dart";
import "package:customer/services/app_firestore_user_db.dart";
import "package:get/get.dart";

class FirebaseSampleController extends GetxController {
  Rx<Query<dynamic>> rxQuery = AppFirestoreUserDB().collectionRef.obs;
}
