import "dart:async";

import "package:customer/models/address_model.dart";
import "package:customer/models/booking_quote_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:geocoding/geocoding.dart";
import "package:get/get.dart";

class BookSlotController extends GetxController {

  final RxInt rxPinCode =  0.obs;
  final RxString rxStreet = "".obs;
  final RxString rxCity = "".obs;
  final RxString rxCountry = "".obs;
  final RxString rxLatitude = "".obs;
  final RxString rxLongitude = "".obs;

  final Rx<AddressModelData> addressData = AddressModelData().obs;

  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  RxString dropDownValue = "".obs;
  RxInt value = RxInt(-1);
  RxDouble sliderSel = 10.0.obs;

  void updateSelectedDate(DateTime date) {
    selectedDate(date);
  }


  void updateDropDownValue(String val) {
    dropDownValue(val);
  }


  void updateValue(val) {
    if (val is bool && !val) {
      value(-1);
    } else {
      value(val ?? -1);
    }
  }


  void updateSliderValue(double value) {
    sliderSel(value);
  }

  void updateAddressData( value) {
    addressData(value);
    return;
  }


  Future<void> addAddressAPICall({
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    required List<Placemark> list,
    required double lat,
    required double long,
  }) async {
    await AppAPIService().functionPost(
      types: Types.oauth,
      endPoint: "address",
      body: <String, dynamic>{
        "pinCode": list.first.postalCode ?? "",
        "street": list.first.street ?? "",
        "city": list.first.locality ?? "",
        "country": list.first.country ?? "",
        "latitude": lat.toString().trim(),
        "longitude": long.toString().trim(),
      },
      successCallback: (Map<String, dynamic> json) async {
        AddressModel addAddressModel = AddressModel();
        addAddressModel = AddressModel.fromJson(json);

        updateAddressData(addAddressModel.data ?? AddressModelData());

        successCallback(json);
      },
      failureCallback: failureCallback,
    );
    return Future<void>.value();
  }


  Future<List<BookingQuoteModelData>> createBookingAPICall({
    required String scheduleDate,
    required String approxStartTime,
    required String approxEndTime,
    required String crop,
    required String deliveryAddress,
    required List<Map<String, dynamic>> services,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
  }) async {
    final Completer<List<BookingQuoteModelData>> completer =
    Completer<List<BookingQuoteModelData>>();
    await AppAPIService().functionPost(
      types: Types.rental,
      endPoint: "booking",
      body: <String, dynamic>{
        "scheduleDate": scheduleDate,
        "approxStartTime": approxStartTime,
        "approxEndTime": approxEndTime,
        "crop": crop,
        "deliveryAddress": deliveryAddress,
        "services": services,
      },
      successCallback: (Map<String, dynamic> json) async {
         BookingQuoteModel bookModel = BookingQuoteModel();
        bookModel = BookingQuoteModel.fromJson(json);

         completer.complete(bookModel.data ?? <BookingQuoteModelData>[]);

        successCallback(json);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "", message: json["message"]);

        completer.complete(<BookingQuoteModelData>[]);
      },
    );
    return completer.future;
  }

}
