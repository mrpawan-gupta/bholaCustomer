import "package:customer/models/crop_categories_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

// For Rental Bookings
const String bookingCreated = "Created";
const String bookingConfirmed = "BookingConfirm";
const String bookingPaymentDone = "PaymentDone";
const String bookingAccepted = "BookingAccepted";
const String bookingWorkInProgress = "WorkInProgress";
const String bookingCompleted = "Completed";
const String bookingCancelled = "Cancelled";
const String bookingRejected = "Rejected";

String getBookingStatusString({required String status}) {
  String value = "";

  switch (status) {
    case bookingCreated:
      value = "Booking - Created";
      break;
    case bookingConfirmed:
      value = "Booking - Confirmed";
      break;
    case bookingPaymentDone:
      value = "Booking - Payment Done";
      break;
    case bookingAccepted:
      value = "Booking - Accepted";
      break;
    case bookingWorkInProgress:
      value = "Booking - Work In Progress";
      break;
    case bookingCompleted:
      value = "Booking - Completed";
      break;
    case bookingCancelled:
      value = "Booking - Cancelled";
      break;
    case bookingRejected:
      value = "Booking - Rejected";
      break;
    default:
      break;
  }

  return value;
}

Color getBorderColor({required String status}) {
  Color value = AppColors().appTransparentColor;

  switch (status) {
    case bookingCreated:
      value = AppColors().appPrimaryColor;
      break;
    case bookingConfirmed:
      value = AppColors().appPrimaryColor;
      break;
    case bookingPaymentDone:
      value = AppColors().appPrimaryColor;
      break;
    case bookingAccepted:
      value = AppColors().appPrimaryColor;
      break;
    case bookingWorkInProgress:
      value = AppColors().appPrimaryColor;
      break;
    case bookingCompleted:
      value = AppColors().appPrimaryColor;
      break;
    case bookingCancelled:
      value = AppColors().appRedColor;
      break;
    case bookingRejected:
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
  final Categories item = Categories(sId: "", name: "All", photo: "");
  final bool isExist = list.contains(item);
  return (isExist, item);
}

(bool, CropCategories) checkAndGetCropCategoryObject({
  required List<CropCategories> list,
}) {
  final CropCategories item = CropCategories(sId: "", name: "All", photo: "");
  final bool isExist = list.contains(item);
  return (isExist, item);
}

// For Display Types
const String displayTypeHour = "hour";
const String displayTypeArea = "area";
const String displayTypeAreaWithMedicine = "areawithmedicine";

String getBookingTypeString({required String status}) {
  String value = "";

  switch (status) {
    case displayTypeHour:
      value = "Hour based";
      break;
    case displayTypeArea:
      value = "Area based";
      break;
    case displayTypeAreaWithMedicine:
      value = "Area & medicine based";
      break;
    default:
      break;
  }

  return value;
}

// For Units
const String unitKG = "kg";
const String unitLitre = "litre";
const String unitML = "ml";
const String unitGram = "gram";
const String unitNOS = "nos";

const String statusApproved = "Approved";
const String statusPending = "Pending";

const String statusActive = "Active";
const String statusInactive = "Inactive";

const String statusBankStatusPending = "Pending";
const String statusBankStatusApproved = "Approved";
const String statusBankStatusRejected = "Rejected";
