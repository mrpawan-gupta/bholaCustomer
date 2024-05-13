import "package:cloud_firestore/cloud_firestore.dart";
import "package:customer/utils/app_logger.dart";
import "package:get/get.dart";

class AppFirestoreUserDB extends GetxService {
  factory AppFirestoreUserDB() {
    return _singleton;
  }

  AppFirestoreUserDB._internal();
  static final AppFirestoreUserDB _singleton = AppFirestoreUserDB._internal();

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final CollectionReference<dynamic> collectionRef =
      FirebaseFirestore.instance.collection("users");

  Stream<QuerySnapshot<dynamic>> readUsers({
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) {
    Stream<QuerySnapshot<dynamic>> stream =
        const Stream<QuerySnapshot<dynamic>>.empty();
    try {
      stream = collectionRef.snapshots();
      successCallback("Records fetched successfully.");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      failureCallback("Records not fetched.");
    } finally {}
    return stream;
  }

  Future<void> addUser({
    required Map<String, dynamic> data,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = await collectionRef.add(data);
      AppLogger().info(message: "addUser():: result.id:: ${result.id}");
      successCallback("User added successfully.");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      failureCallback("User not added.");
    } finally {}
    return Future<void>.value();
  }

  Future<void> updateOrSetUser({
    required String id,
    required Map<String, dynamic> data,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = collectionRef.doc(id);
      final DocumentSnapshot<dynamic> docs = await result.get();
      docs.exists
          ? await updateUser(
              id: id,
              data: data,
              successCallback: successCallback,
              failureCallback: failureCallback,
            )
          : await setUser(
              id: id,
              data: data,
              successCallback: successCallback,
              failureCallback: failureCallback,
            );
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      failureCallback("User not updated or set.");
    } finally {}
    return Future<void>.value();
  }

  Future<void> updateUser({
    required String id,
    required Map<String, dynamic> data,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = collectionRef.doc(id);
      await result.update(data);
      AppLogger().info(message: "updateUser():: result.id:: ${result.id}");
      successCallback("User updated successfully.");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      failureCallback("User not updated.");
    } finally {}
    return Future<void>.value();
  }

  Future<void> setUser({
    required String id,
    required Map<String, dynamic> data,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = collectionRef.doc(id);
        await result.set(data);
      AppLogger().info(message: "setUser():: result.id:: ${result.id}");
      successCallback("User Set successfully.");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      failureCallback("User not set.");
    } finally {}
    return Future<void>.value();
  }

  Future<void> deleteUser({
    required String id,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = collectionRef.doc(id);
      await result.delete();
      AppLogger().info(message: "deleteUser():: result.id:: ${result.id}");
      successCallback("User deleted successfully.");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      failureCallback("User not deleted.");
    } finally {}
    return Future<void>.value();
  }
}
