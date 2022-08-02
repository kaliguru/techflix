
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/data/services/api_service.dart';


import '../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/controller/auth/auth/forget_password_controller.dart';
import '../../../../../data/repo/auth/login_repo.dart';
import '../../../../components/CustomBackSupportAppbar.dart';
import '../../../../components/bg_widget/bg_image_widget.dart';
import '../../../../components/rounded_button.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {



  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find(),sharedPreferences: Get.find()));
    final controller=Get.put(ForgetPasswordController(loginRepo: Get.find()));
    controller.email=Get.arguments;
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyBgWidget(),
        WillPopScope(
          onWillPop: ()async{

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child:  CustomBackSupportAppBar(press: (){
                Get.offAndToNamed(RouteHelper.loginScreen);
              },showTitle: true,title: MyStrings.passVerification,),
            ),
            body: SizedBox(
              child: GetBuilder<ForgetPasswordController>(builder: (controller)=>SingleChildScrollView(
                child: Stack(

                  children: [
                    Column(
                      children: [

                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(15),
                         width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            text: MyStrings.yourEmailAddress,
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
                                height: 40,
                              ),

                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 2),
                                  child: PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle: mulishSemiBold.copyWith(color:MyColor.colorWhite),
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
                                        inactiveColor: Colors.grey.shade600.withOpacity(0.5),
                                        activeColor: Colors.white24,
                                        activeFillColor: MyColor.bgColor,
                                        selectedFillColor: MyColor.textFieldColor,
                                        selectedColor: Colors.white24,
                                      inactiveFillColor: Colors.transparent
                                    ),
                                    cursorColor: Colors.white,
                                    textStyle: mulishSemiBold.copyWith(color: Colors.white),
                                    animationDuration: const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    keyboardType: TextInputType.number,
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                        /*blurRadius: 10,*/
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
                                    controller.hasError ? "*Please fill up all the cells properly" : "",
                                    style:mulishRegular,)
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                child: controller.isLoading?const Center(child: CircularProgressIndicator(),) :RoundedButton(width:1,text: 'Verify', press: (){
                                  if (controller.currentText.length != 6) {
                                    controller.hasError=true;
                                  } else {
                                    controller.verifyForgetPasswordCode(controller.currentText);
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
                                  controller.isResendLoading?const SpinKitFadingCircle(size: 20,color: MyColor.primaryColor,):TextButton(
                                      onPressed: () {
                                        controller.resendForgetPassCode();
                                      },
                                      child: Text(MyStrings.resend,
                                          style: mulishBold.copyWith(
                                              decoration: TextDecoration.underline,
                                              color:
                                              MyColor.colorWhite)))
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                            ],
                          ),
                        ),

                      ],
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

