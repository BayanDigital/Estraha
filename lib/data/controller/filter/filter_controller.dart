

import 'dart:convert';

import 'package:booking_box/data/model/filter_pram/filter_pram_response_model.dart';
import 'package:booking_box/data/repo/filter_pram/filter_pram_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class FilterController extends GetxController{

  FilterPramRepo filterPramRepo;
  FilterController({required this.filterPramRepo});

  late RangeValues currentRangeValues;

  double minPrice = 0.00; //fixed
  double maxPrice = 100.00;

  String curSymbol = "\$";

  int selectedHotelClass = -1;
  int selectedRating= -1;
  int selectedPropertyType = 0;

  bool isLoading = true;

  Future<void> loadData() async{
    isLoading = true;
    update();

    await loadFilterPramData();

    isLoading = false;
    // isLoaded = true;
    update();

  }

  List<Amenities> amenitiesList = [];
  List<Facilities> facilitiesList = [];

  int maxStarRating = 2;

  Future<void> loadFilterPramData() async {

    ResponseModel model = await filterPramRepo.getData();
    if(model.statusCode == 200){

       FilterPramResponseModel filterPramResponseModel = FilterPramResponseModel.fromJson(jsonDecode(model.responseJson));

      if(filterPramResponseModel.data !=  null){


        minPrice = double.tryParse(filterPramResponseModel.data?.minFare ?? "0.00") ?? 0.00;
        maxPrice = double.tryParse(filterPramResponseModel.data?.maxFare ?? "100.00") ?? 100.00;

        currentRangeValues = RangeValues(minPrice, maxPrice);

        maxStarRating = int.parse(filterPramResponseModel.data!.maxStarRating ?? '7');

        if(filterPramResponseModel.data?.amenities != null && filterPramResponseModel.data!.amenities!.isNotEmpty){
          amenitiesList.addAll(filterPramResponseModel.data!.amenities!);
        }

        if(filterPramResponseModel.data?.facilities != null && filterPramResponseModel.data!.facilities!.isNotEmpty){
          facilitiesList.addAll(filterPramResponseModel.data!.facilities!);
        }
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  bool facilities = false;
  bool amenities = false;

  toggleFacilities(){
    facilities = !facilities;
    update();
  }

  toggleAmenities(){
    amenities = !amenities;
    update();
  }

  void updateCurrentRangeValue(RangeValues rangeValues){
    currentRangeValues = rangeValues;
    update();
  }

  void setSelectedHotelClass(int index){
    selectedHotelClass = index;
    update();
  }

  void setSelectedFacilities(int index){
    facilitiesList[index].changeSelectedValue();
    update();
  }

  List<String>  selectedAmenitiesIdList = [];
  List<String>  selectedFacilitiesIdList = [];

  storeAmenitiesFacilitiesId(){

    selectedAmenitiesIdList.clear();
    selectedFacilitiesIdList.clear();

    for (var element in amenitiesList) {
      if(element.isSelect){
        selectedAmenitiesIdList.add(element.id.toString());
      }
    }

    for (var element in facilitiesList) {
      if(element.isSelect){
        selectedFacilitiesIdList.add(element.id.toString());
      }
    }
    update();
  }

  void setSelectedAmenities(int index){
    amenitiesList[index].changeSelectedValue();
    amenitiesList[index].isSelect;
    update();
  }

  void setPropertyType(int index){
    selectedPropertyType = index;
    update();
  }

  void resetFilter(){
    selectedHotelClass = -1;
    currentRangeValues = const RangeValues(100, 500);
    update();
  }
}