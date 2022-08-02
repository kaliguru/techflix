
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import '../../../../../core/utils/my_color.dart';
import '.././../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/deposit_controller/add_new_deposit_controller.dart';
import '../../../../data/model/deposit/MainDepositMethodResponseModel.dart';
import '../../../components/rounded_button.dart';
import '../../../components/text_field_container2.dart';

class Body extends StatefulWidget {
  final String price;
  final String planName;
  final String subscriptionId;
 const Body({Key? key,required this.price,required this.planName,required this.subscriptionId}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AddNewDepositController>().beforeInitLoadData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(
      builder: (controller) =>
          SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child:
              controller.isLoading?const Center(child: CircularProgressIndicator(),):Center(
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.fontExtraLarge),
                  margin: Dimensions.dialogContainerMargin,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                        color: MyColor.colorBlack,
                      border: Border.all(color: Colors.white54,width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                      ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text.rich(

                          TextSpan(text:MyStrings.yourRequested,style:mulishRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontExtraLarge
                          ,),
                          children: [
                            TextSpan(text: '${widget.planName}\n',style:mulishSemiBold.copyWith(color: MyColor.primaryColor,fontSize: Dimensions.fontOverLarge),),
                            TextSpan(text: MyStrings.nowYouHave,style:mulishRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontExtraLarge),),
                            TextSpan(text: CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(widget.price),style:mulishSemiBold.copyWith(color: MyColor.primaryColor,fontSize: Dimensions.fontOverLarge),),
                            TextSpan(text: ' ${controller.currency}',style:mulishRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontExtraLarge),),
                          ]
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                       const SizedBox(
                        height: 30,
                      ),
                      const Text(MyStrings.paymentMethod,style: mulishSemiBold,),
                      const SizedBox(height: 10,),

                      TextFieldContainer2(
                        fillColor: MyColor.textFieldColor,
                          onTap: () {  },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 10),
                            child: DropdownButton<Methods>(
                              hint:  const Text(MyStrings.selectAMethod),
                              dropdownColor: MyColor.textFieldColor,
                              value: controller.paymentMethod,
                                elevation: 8,
                                icon: const Icon(Icons.arrow_drop_down_circle),
                            iconDisabledColor: Colors.red,
                            iconEnabledColor: MyColor.primaryColor,
                            isExpanded: true,
                            underline: Container(
                              height: 0,
                              color: Colors.deepPurpleAccent,
                            ),
                              onChanged: (Methods? newValue) {
                                controller.setPaymentMethod(newValue);
                              },
                              items: controller.paymentMethodList.map((Methods method) {
                                return DropdownMenuItem<Methods>(
                                  value: method,
                                  child: Text(
                                   method.name.toString(),
                                    style: mulishRegular.copyWith(color: MyColor.colorWhite),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                      const SizedBox(height: 15,),
                      controller.charge==''?const SizedBox():Text(controller.charge,style: mulishRegular,),
                      const SizedBox(height: 30,),
                      controller.isLoading
                          ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme
                                    .of(context)
                                    .primaryColor),
                          )) :
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: RoundedButton(
                            width: 1,
                            press: () {
                              controller.submitDeposit(widget.price,widget.subscriptionId);
                            },
                            text: MyStrings.paymentNow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
    );
  }
}
