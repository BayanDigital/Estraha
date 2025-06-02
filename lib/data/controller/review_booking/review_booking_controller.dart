

import 'dart:convert';

import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/data/model/booking_request/booking_request_response_model.dart';
import 'package:booking_box/data/model/profile/profile_response_model.dart';
import 'package:booking_box/data/model/review_booking/booking_request_model.dart';
import 'package:booking_box/data/repo/review_booking/review_booking_repo.dart';
import 'package:booking_box/environment.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/helper/date_converter.dart';
import '../../../core/utils/my_strings.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/country_model/country_model.dart';
import '../../model/global/response_model/response_model.dart';

class ReviewBookingController extends GetxController{

  ReviewBookingRepo reviewBookingRepo;
  ReviewBookingController({required this.reviewBookingRepo});

  final FocusNode nameFocusNode       = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  String initialGuestName = '';

  TextEditingController nameController        = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController searchController      = TextEditingController();
  TextEditingController countryController     = TextEditingController();

  String countryCode = "";
  String mobileCode = "";
  String countryName = "";
  String guestName = "";
  String mobileNumber = "";

  List<Countries> countryList = [];

  String selectedCountryDialCode = Environment.dialCode;

  bool countryLoading = false;

  Future<void> loadData() async{
    if(countryList.isEmpty){
      countryLoading = true;
      update();
    }
      await getUserInfo();
      await getCountryData();
    countryLoading = false;
    update();
  }

  bool submitLoading = false;

  requestBooking() async {

    submitLoading=true;
    update();

    BookingRequestModel model = getBookingRequestData();

    ResponseModel responseModel = await reviewBookingRepo.requestBooking(model,Get.find<RoomSelectController>().selectedRoomList);

    if(responseModel.statusCode == 200){
      BookingRequestResponseModel model = BookingRequestResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ??[MyStrings.success.tr]);
        Get.toNamed(RouteHelper.bookingRequestScreen,arguments: false);
        nameController.clear();
        phoneNumberController.clear();
      } else {
        CustomSnackBar.error(errorList:model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading=false;
    update();
  }

  void clearTextField(){
    nameController.clear();
    phoneNumberController.clear();
    update();
  }

  BookingRequestModel getBookingRequestData() {
    var homeController = Get.find<HomeController>();
    BookingRequestModel model = BookingRequestModel(
        checkIn: DateConverter.formattedDate(homeController.checkInDate),
        checkOut:  DateConverter.formattedDate(homeController.checkOutDate),
        ownerId: Get.find<HotelDetailsScreenController>().hotelSetting?.ownerId??'',
        contactName: nameController.text,
        contactNumber: '$selectedCountryDialCode${phoneNumberController.text}',
        totalAdults: Get.find<HomeController>().numberOfAdults.toString(),
        totalChildren: Get.find<HomeController>().numberOfChildren.toString()
    );
    return model;
  }


  setSelectedCountryDialCode(String dialCode){
    selectedCountryDialCode = '+$dialCode';
    update();
  }


  Countries selectedCountryData = Countries(
      countryCode: Environment.defaultCountryCode,
      dialCode: Environment.dialCode,
      country: Environment.countryName
  );

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;

    selectedCountryDialCode = mobileCode;
    update();
  }

  var countryFlag = MyImages.defaultImageNetwork;

  Future<dynamic> getCountryData() async {

    ResponseModel mainResponse = await reviewBookingRepo.getCountryData();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.clear();
        filteredCountries.clear();
        countryList.addAll(tempList);
        filteredCountries.addAll(tempList);
      }
      var selectDefCountry = tempList!.firstWhere(
            (country) => country.countryCode!.toLowerCase() == Environment.defaultCountryCode.toLowerCase(),
        orElse: () => Countries(),
      );

      if (selectDefCountry.dialCode != null) {
        setCountryNameAndCode(selectDefCountry.country.toString(), selectDefCountry.countryCode.toString(), selectDefCountry.dialCode.toString());
      }
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);
    }

    countryLoading = false;
    update();
  }

  getUserInfo() async {
    ResponseModel responseModel = await reviewBookingRepo.getUserData();
    if(responseModel.statusCode == 200){
      ProfileResponseModel model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.data!=null && model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        countryCode = model.data?.user?.countryCode ?? "";
        mobileCode = model.data?.user?.dialCode ?? "";
        countryName = model.data?.user?.countryName ?? "";

        nameController.text = "${model.data?.user?.firstname} ${model.data?.user?.lastname}";
        phoneNumberController.text = "${model.data?.user?.mobile}";
      }
    } else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    update();
  }

  selectCountryData(Countries country) {
    selectedCountryData = country;
    setCountryNameAndCode(country.country ?? '', country.countryCode ?? '', country.dialCode??'');
    update();
  }

  List<Countries> filteredCountries = [];

}

