
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_images.dart';

import '../../../../../constants/my_strings.dart';

import '../../../../../../core/utils/my_color.dart';
import '../../../../../data/controller/account/profile_controller.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/from_errors.dart';
import '../../../../components/label_text.dart';
import '../../../../components/rounded_button.dart';
import 'profile_image.dart';

class Body extends StatelessWidget {
  const Body({Key? key,this.comeFrom='profile'}) : super(key: key);
  final String comeFrom;

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().callFrom=comeFrom;
    return GetBuilder<ProfileController>(builder: (controller)=>
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: MyColor.bodyTextColor,width: 1),
              borderRadius: BorderRadius.circular(10),
              color: MyColor.secondaryColor2,
          ),
          child: controller.isLoading?const Center(child: CircularProgressIndicator(),):SingleChildScrollView(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                ProfileWidget(
                  isEdit: true,
                    imagePath:  MyImages.profile,
                    onClicked: ()async{
                    }
                ),
                Center(child: LabelText(text:'Username : ${controller.model.data?.user?.username??''}'),),
              const SizedBox(height: 15,),
              const LabelText(text: 'First Name',space: 12,),
                CustomTextField(
                  hintText: 'First Name',
                  isShowBorder: true,
                  isPassword: false,
                  isShowSuffixIcon: false,
                  fillColor: MyColor.textFieldColor,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  focusNode: controller.firstNameFocusNode,
                  controller: controller.firstNameController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.removeError(error: MyStrings.kFirstNameNullError);
                    }
                    if (value.isEmpty) {
                      controller.addError(error: MyStrings.kFirstNameNullError);
                    }
                    return;
                  },
                  nextFocus: controller.lastNameFocusNode,
                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'Last Name'),
                CustomTextField(
                  hintText: 'Last Name',
                  isShowBorder: true,
                  isPassword: false,
                  isShowSuffixIcon: false,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  focusNode: controller.lastNameFocusNode,
                  controller: controller.lastNameController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.removeError(error: MyStrings.kLastNameNullError);
                    }
                    if (value.isEmpty) {
                      controller.addError(error: MyStrings.kLastNameNullError);
                    }
                    return;
                  },
                  nextFocus: controller.addressFocusNode,
                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'E-mail Address'),
                CustomTextField(
                  hintText: 'E-mail Address',
                  isShowBorder: true,
                  isPassword: false,
                  isShowSuffixIcon: false,
                  isEnabled: false,
                  controller: controller.emailController,
                  onChanged: (value) {
                    return;
                  },

                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'Mobile Number'),
                CustomTextField(
                  hintText: 'Mobile Number',
                  isShowBorder: true,
                  isPassword: false,
                  isEnabled: false,
                  isShowSuffixIcon: false,
                  controller: controller.mobileNoController,
                  onSuffixTap: () {},
                  onChanged: (value) {
                    return;
                  },
                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'Address'),
                CustomTextField(
                  hintText: 'Address',
                  isShowBorder: true,
                  isPassword: false,
                  isShowSuffixIcon: false,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  focusNode: controller.addressFocusNode,
                  controller: controller.addressController,
                  onSuffixTap: () {},
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.removeError(error: MyStrings.kPassNullError);
                    }
                    if (value.isEmpty) {
                      controller.addError(error: MyStrings.kPassNullError);
                    }
                    return;
                  },
                  nextFocus: controller.stateFocusNode,
                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'State'),
                CustomTextField(
                  hintText: 'State',
                  isShowBorder: true,
                  isPassword: false,
                  isShowSuffixIcon: false,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  focusNode: controller.stateFocusNode,
                  controller: controller.stateController,
                  onSuffixTap: () {},
                  onChanged: (value) {
                    return;
                  },
                  nextFocus: controller.zipCodeFocusNode,
                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'Zip Code'),
                CustomTextField(
                  hintText: 'Zip Code',
                  isShowBorder: true,
                  isPassword: false,
                  isShowSuffixIcon: false,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  focusNode: controller.zipCodeFocusNode,
                  controller: controller.zipCodeController,
                  onSuffixTap: () {},
                  onChanged: (value) {

                    return;
                  },
                  nextFocus: controller.cityFocusNode,
                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'City'),
                CustomTextField(
                  hintText: 'City',
                  isShowBorder: true,
                  isPassword: false,
                  isShowSuffixIcon: false,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  focusNode: controller.cityFocusNode,
                  controller: controller.cityController,
                  onSuffixTap: () {},
                  onChanged: (value) {

                    return;
                  },
                ),
              const SizedBox(height: 15,),
              const LabelText(space: 12,text: 'Country'),
                CustomTextField(
                  hintText: 'Country',
                  isShowBorder: true,
                  isPassword: false,
                  isEnabled: false,
                  isShowSuffixIcon: false,
                  controller: controller.countryController,
                  onSuffixTap: () {},
                  onChanged: (value) {
                    return;
                  },

                ),
                const SizedBox(height: 12,),
                FormError(errors: controller.errors),
                const SizedBox(height: 30,),
                Center(child: RoundedButton(text: 'Update Profile', press: (){
                  if(controller.errors.isEmpty){
                      controller.updateProfile(comeFrom);
                  }
                }))
              ],
            ),
          ),
        ));
  }
}
