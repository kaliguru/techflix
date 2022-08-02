import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/bg_widget/bg_image_widget.dart';
import 'package:play_lab/view/components/custom_text_form_field.dart';

import '../../../../core/route/route.dart';
import '../../../../../core/utils/my_color.dart';
import '.././../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/auth/login_controller.dart';
import '../../../../data/repo/auth/login_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/rounded_button.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

bool b=false;

final formKey=GlobalKey<FormState>();

  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
        statusBarColor: MyColor.transparentColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.colorBlack,
        systemNavigationBarIconBrightness: Brightness.light));

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      b=true;
      Get.find<LoginController>().isLoading=false;
      Get.find<LoginController>().remember=false;
    });

  }

  @override
  void dispose() {
   b=false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyBgWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(isShowBackBtn: false,title: '',bgColor: Colors.transparent,),
          body: GetBuilder<LoginController>(
            builder: (auth) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset("assets/images/app_logo.png"),
                       SizedBox(
                       height: MediaQuery.of(context).size.height*.1,
                      ),
                      InputTextFieldWidget(fillColor:Colors.grey[600]!.withOpacity(0.5),hintTextColor:Colors.white,controller: auth.emailController, hintText: MyStrings.enterUserNameOrEmail),
                      const SizedBox(
                        height: 5,
                      ),
                      InputTextFieldWidget(
                          fillColor:Colors.grey[600]!.withOpacity(0.5),hintTextColor:Colors.white,
                          isPassword: true,
                          controller: auth.passwordController,
                          hintText: MyStrings.enterYourPassword_),

                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Checkbox(
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => const BorderSide(width: 1.0, color: Colors.white),
                                      ),
                                      activeColor: MyColor.primaryColor,
                                      value: auth.remember,
                                      onChanged: (value) {
                                        auth.changeRememberMe();
                                      }),
                                ),
                                Text(
                                  MyStrings.rememberMe,
                                  style: openSansSemiBold.copyWith(
                                      color: MyColor.colorWhite,
                                      fontSize: Dimensions.fontDefault),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(RouteHelper.forgetPasswordScreen);
                              },
                              child: Text(
                                MyStrings.forgetYourPassword,
                                style: openSansSemiBold.copyWith(
                                    color: MyColor.primaryColor,
                                    fontSize: Dimensions.fontDefault,decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      auth.isLoading
                          ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ))
                          : RoundedButton(
                        press: () {
                          if(formKey.currentState!.validate()){
                            auth.changeIsLoading();
                            auth.loginUser(auth.emailController.text,auth.passwordController.text);
                          }else{

                          }
                        },
                        text: MyStrings.signIn,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          MyStrings.notAccount,
                          style: mulishSemiBold.copyWith(
                              color: MyColor.colorWhite,
                              fontSize: Dimensions.fontLarge),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.offAndToNamed(RouteHelper.registrationScreen);
                          },
                          child: Text(
                            MyStrings.signUp,
                            style: mulishBold.copyWith(
                                fontSize: 18, color: MyColor.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60,),
                      InkWell(
                        splashColor: MyColor.primaryColor,
                        hoverColor: MyColor.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        onTap: (){
                          auth.clearAllSharedData();
                          Get.toNamed(RouteHelper.homeScreen);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.transparent,
                              border: Border.all(color: MyColor.textFieldColor,width: 2),
                            ),
                            child: Text(MyStrings.asAGuest,style: mulishSemiBold.copyWith(color: MyColor.colorWhite),
                            )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text("Copyright © By Phone X App Solutions",style: TextStyle(fontWeight: FontWeight.w900),),
                        ),

                      )

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
