import "package:cloud_firestore/cloud_firestore.dart";

QueryDocumentSnapshot<dynamic>? getListItem({
  required QuerySnapshot<dynamic>? snapshotData,
  required int index,
}) {
  return snapshotData?.docs[index];
}

String getId({required QueryDocumentSnapshot<dynamic>? docsData}) {
  return docsData?.id ?? "";
}

Map<String, dynamic> getData({
  required QueryDocumentSnapshot<dynamic>? docsData,
}) {
  return docsData?.data() ?? <String, dynamic>{};
}
