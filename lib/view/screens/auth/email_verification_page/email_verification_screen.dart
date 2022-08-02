
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/util.dart';
import 'package:play_lab/data/services/api_service.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/auth/auth/email_verification_controller.dart';
import '../../../../data/repo/auth/sms_email_verification_repo.dart';
import '../../../components/CustomBackSupportAppbar.dart';
import '../../../components/bg_widget/bg_image_widget.dart';
import '../../../components/rounded_button.dart';



class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key, required this.needSmsVerification})
      : super(key: key);

  final bool needSmsVerification;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    MyUtil.changeTheme();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    Get.put(EmailVerificationController(
        repo: Get.find(), sharedPreferences: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<EmailVerificationController>().loadData();
    });
  }

  @override
  void dispose() {
    Get.find<EmailVerificationController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<EmailVerificationController>().needSmsVerification =
        widget.needSmsVerification;
    return const PinCodeVerificationScreen();
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  //final String? phoneNumber;

  const PinCodeVerificationScreen({Key? key}) : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyBgWidget(),
        WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                child: CustomBackSupportAppBar(
                  press: () {
                    Get.offAndToNamed(RouteHelper.loginScreen);
                  },
                  showTitle: true,
                  title: MyStrings.emailVerification,
                ),
              ),
              body: GetBuilder<EmailVerificationController>(
                builder: (controller) => controller.dataLoading
                    ? const SizedBox(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .1),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: RichText(
                                text: const TextSpan(
                                    text: MyStrings.weHaveSent,
                                    children: [
                                      TextSpan(
                                          text: MyStrings.yourEmailAddress,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19)),
                                    ],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
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
                                      inactiveColor:
                                          Colors.grey.shade600.withOpacity(0.5),
                                      activeColor: Colors.white24,
                                      activeFillColor: MyColor.bgColor,
                                      selectedFillColor: MyColor.textFieldColor,
                                      selectedColor: Colors.white24,
                                      inactiveFillColor: Colors.transparent),
                                  cursorColor: Colors.white,
                                  textStyle: mulishSemiBold.copyWith(
                                      color: Colors.white),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  errorAnimationController:
                                      controller.errorController,
                                  keyboardType: TextInputType.number,
                                  boxShadows: const [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      color: Colors.black12,
                                      blurRadius: 10,
                                    )
                                  ],
                                  onCompleted: (v) {},
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Text(
                                  controller.hasError
                                      ? MyStrings.plsFillProperly
                                      : "",
                                  style: mulishRegular.copyWith(
                                      color: MyColor.colorWhite),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: controller.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : RoundedButton(
                                      text: MyStrings.verify,
                                      press: () {
                                        if (controller.currentText.length !=
                                            6) {
                                          controller.errorController!
                                              .add(ErrorAnimationType.shake);
                                          controller.hasError = true;
                                        } else {
                                          controller.verifyEmail(
                                              controller.currentText);
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
                                            decoration:
                                                TextDecoration.underline,
                                            color: MyColor.colorWhite)))
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
