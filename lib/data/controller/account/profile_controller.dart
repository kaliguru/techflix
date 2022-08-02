
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/utils/url_container.dart';

import '../../../constants/my_strings.dart';

import '../../model/account/ProfileResponseModel.dart';
import '../../model/account/user_post_model/UserPostModel.dart';
import '../../repo/account/profile_repo.dart';



class ProfileController extends GetxController implements GetxService {

  ProfileRepo profileRepo;

 ProfileResponseModel model=ProfileResponseModel();

  String imageStaticUrl='';
  String callFrom='';

  ProfileController({required this.profileRepo});

  List<String> errors = [];
  String imageUrl='';
  String? currentPass, password, confirmPass;
  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;

  addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
    }
  }

  removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
    }
  }


  loadProfileInfo() async {
    isLoading = true;
    update();
    model= await profileRepo.loadProfileInfo();
    if(model.data!=null && model.status=='success'){
      loadData(model);
    }else{
       isLoading=false;
       update();
    }

  }

  void clearAllData() {

  }

  updateProfile(String callFrom)async{

    String firstName=firstNameController.text;
    String lastName=lastNameController.text.toString();
    String address=addressController.text.toString();
    String city=cityController.text.toString();
    String zip=zipCodeController.text.toString();
    String state=stateController.text.toString();
    User? user=model.data?.user;

   // UserPostModel m=UserPostModel(firstname: firstNameController.text.toString(), lastName: lastNameController.text.toString(), mobile: user?.mobile??'', email: user?.email??'', username: user?.username??'', countryCode: user?.countryCode??'', country: user?.address?.country??'', mobileCode: '', image:"imageString", address: addressController.text.toString(), state: stateController.text.toString(), zip: zipCodeController.text.toString(), city: cityController.text.toString());

    if(firstName.isNotEmpty && lastName.isNotEmpty){
      isLoading=true;
      update();
      UserPostModel model=UserPostModel(
          firstname: firstName, lastName: lastName, mobile: user?.mobile??'', email: user?.email??'',
          username: user?.username??'', countryCode: user?.countryCode??'', country: user?.address?.country??'', mobileCode: '880',
          image:imageFile, address: address, state: state,
          zip: zip, city: city);

        bool b= await profileRepo.updateProfile(model,callFrom);



       if(b){
           await loadProfileInfo();
         if(callFrom.toLowerCase()=='profile_complete'.toLowerCase()){
           Get.back();
           return;
         }
           callFrom='profile';
       }

      isLoading=false;
      update();
    }else{
      if(firstName.isEmpty){
        addError(error: MyStrings.kFirstNameNullError);
      } if(lastName.isEmpty){
        addError(error: MyStrings.kLastNameNullError);
      }
    }

  }

  void loadData(ProfileResponseModel? model) {
     firstNameController.text=model?.data?.user?.firstname??'';
     profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.firstname??''} ${model?.data?.user?.lastname??''}');
     lastNameController.text = model?.data?.user?.lastname??'';
     emailController.text = model?.data?.user?.email??'';
     mobileNoController.text = model?.data?.user?.mobile??'';
     addressController.text =model?.data?.user?.address?.address??'';
     stateController.text = model?.data?.user?.address?.state??'';
     zipCodeController.text = model?.data?.user?.address?.zip??'';
     cityController.text = model?.data?.user?.address?.city??'';
     countryController.text = model?.data?.user?.address?.country??'';
     isLoading=false;

     update();
  }
}
