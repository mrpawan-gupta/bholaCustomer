import "dart:ui";

import "package:customer/models/featured_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:intl/intl.dart";

// From: Back-End
// const CREATED = 'Created';
// const BOOKINGCONFIRM = 'BookingConfirm';
// const BOOKINGACCEPTED = 'BookingAccepted';
// const PAYMENTDONE = 'PaymentDone';
// const WORKINPROGRESS = 'WorkInProgress';
// const COMPLETED = 'Completed';
// const CANCELLED = 'Cancelled';

String getBookingStatusString({required String status}) {
  String value = "";

  switch (status) {
    case "Created":
      value = "Booking - Created";
      break;
    case "BookingConfirm":
      value = "Booking - Confirmed";
      break;
    case "BookingAccepted":
      value = "Booking - Accepted";
      break;
    case "PaymentDone":
      value = "Booking - Payment Done";
      break;
    case "WorkInProgress":
      value = "Booking - Work In Progress";
      break;
    case "Completed":
      value = "Booking - Completed";
      break;
    case "Cancelled":
      value = "Booking - Cancelled";
      break;
    default:
      break;
  }
  return value;
}

Color getBorderColor({required String status}) {
  Color value = AppColors().appTransparentColor;

  switch (status) {
    case "Created":
      value = AppColors().appGrey;
      break;
    case "BookingConfirm":
      value = AppColors().appPrimaryColor;
      break;
    case "BookingAccepted":
      value = AppColors().appPrimaryColor;
      break;
    case "PaymentDone":
      value = AppColors().appGrey;
      break;
    case "WorkInProgress":
      value = AppColors().appGrey;
      break;
    case "Completed":
      value = AppColors().appPrimaryColor;
      break;
    case "Cancelled":
      value = AppColors().appRedColor;
      break;
    default:
      break;
  }
  return value;
}

String formatDate({required String date}) {
  final DateTime originalDate = DateTime.parse(date);
  final String formattedDate = DateFormat("dd-MM-yyyy").format(originalDate);
  return formattedDate;
}

String formatTime({required String time}) {
  final DateTime originalTime = DateTime.parse(time);
  final String formattedTime = DateFormat("hh:mm a").format(originalTime);
  return formattedTime;
}

(bool, Categories) checkAndGetCategoryObject({required List<Categories> list}) {
  final Categories category = Categories(sId: "", name: "All", photo: "");
  final bool isExist = list.contains(category);
  return (isExist, category);
}
