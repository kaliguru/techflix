
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/util.dart';
import 'package:play_lab/data/services/api_service.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/route/route.dart';
import '../../../../data/controller/auth/auth/sms_verification_controler.dart';
import '../../../../data/repo/auth/sms_email_verification_repo.dart';
import '../../../components/CustomBackSupportAppbar.dart';
import '../../../components/bg_widget/bg_image_widget.dart';
import '../../../components/rounded_button.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SmsVerificationController>().loadBefore();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SmsPinVerificationBody();
  }
}

class SmsPinVerificationBody extends StatefulWidget {
  const SmsPinVerificationBody({Key? key}) : super(key: key);

  @override
  _SmsPinVerificationBodyState createState() => _SmsPinVerificationBodyState();
}

class _SmsPinVerificationBodyState extends State<SmsPinVerificationBody> {
  @override
  void initState() {
    MyUtil.changeTheme();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyBgWidget(),
        Scaffold(
            backgroundColor: MyColor.colorBlack,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: CustomBackSupportAppBar(
                press: () {
                  Get.find<SmsVerificationController>().clearData();
                  Get.offAndToNamed(RouteHelper.loginScreen);
                },
                showTitle: true,
                title: MyStrings.smsVerification,
              ),
            ),
            body: GetBuilder<SmsVerificationController>(
              builder: (controller) => SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.1),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: RichText(
                          text: const TextSpan(
                              text: MyStrings.weHaveSent,
                              children: [
                                TextSpan(
                                    text: MyStrings.yourPhnNumber,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19)),
                              ],
                              style: TextStyle(color: Colors.white, fontSize: 20)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: mulishSemiBold.copyWith(
                                color: MyColor.primaryColor400),
                            length: 6,
                            obscureText: false,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(4),
                                fieldHeight: 50,
                                fieldWidth: 45,
                                inactiveColor: MyColor.textFieldColor,
                                activeColor: Colors.white24,
                                activeFillColor: MyColor.bgColor,
                                selectedFillColor: MyColor.textFieldColor,
                                selectedColor: Colors.white24,
                                inactiveFillColor: MyColor.bgColor
                            ),
                            cursorColor: Colors.white,
                            textStyle: mulishSemiBold.copyWith(color: Colors.white),
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: controller.errorController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {

                            },
                            onChanged: (value) {

                              setState(() {
                                controller.currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {

                              return true;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            controller.hasError ? MyStrings.plsFillProperly : "",
                            style: mulishRegular,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: controller.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : RoundedButton(
                                text: MyStrings.verify,
                                press: () {
                                  if (controller.currentText.length != 6) {
                                    controller.errorController!
                                        .add(ErrorAnimationType.shake);
                                    controller.hasError = true;
                                  } else {
                                    controller.verifyYourSms();
                                  }
                                }),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            MyStrings.didNotReceiveCode,
                            style: mulishRegular,
                          ),
                          TextButton(
                              onPressed: () {
                                controller.sendCodeAgain();
                              },
                              child: Text(MyStrings.resend,
                                  style: mulishBold.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: MyColor.colorWhite)))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
