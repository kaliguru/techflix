import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/util.dart';
import 'package:play_lab/data/services/api_service.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/route/route.dart';
import '../../../../../data/controller/auth/auth/forget_password_controller.dart';
import '../../../../../data/repo/auth/login_repo.dart';
import '../../../../components/CustomBackSupportAppbar.dart';
import '../../../../components/bg_widget/bg_image_widget.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/from_errors.dart';
import '../../../../components/rounded_button.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  void initState() {

    MyUtil.changeTheme();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find(),sharedPreferences: Get.find()));
    final controller =Get.put(ForgetPasswordController(loginRepo: Get.find()));
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
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void dispose() {
    Get.find<ForgetPasswordController>().errors.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.find<ForgetPasswordController>().isLoading=false;
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
              child:  CustomBackSupportAppBar(
              title:MyStrings.resetPassword,press: (){
                Get.offAndToNamed(RouteHelper.loginScreen);
              }),
            ),
            body: GetBuilder<ForgetPasswordController>(
              builder: (controller) => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SizedBox(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.1),
                      const Padding(
                        padding:
                         EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: Text(
                          MyStrings.resetLabelText,
                              style: TextStyle(color: Colors.white, fontSize: Dimensions.authTextSize),
                          textAlign: TextAlign.center,

                      ),),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                          children: [

                            CustomTextField(
                                focusNode: controller.passwordFocusNode,
                                nextFocus: controller.confirmPasswordFocusNode,
                                hintText: MyStrings.password,
                                isShowSuffixIcon: true,
                                isPassword: true,
                                inputType: TextInputType.text,
                                onChanged: (value) {
                                  controller.password=value;
                                  if (value.isNotEmpty) {
                                    controller.removeError(
                                        error: MyStrings.kPassNullError);
                                  }else{
                                    controller.addError(
                                        error: MyStrings.kPassNullError);
                                  }
                                  if(controller.password.toString()==controller.confirmPassword.toString()){
                                    controller.removeError(error: MyStrings.kMatchPassError);
                                    return;
                                  }else{
                                    controller.addError(error: MyStrings.kMatchPassError);
                                    return;
                                  }
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                                inputAction: TextInputAction.done,
                                isPassword: true,
                                hintText: MyStrings.confirmPassword,
                                isShowSuffixIcon: true,
                                onChanged: (value){
                                  controller.confirmPassword=value;
                                   if(controller.password.toString()==controller.confirmPassword.toString()){
                                    controller.removeError(error: MyStrings.kMatchPassError);
                                    return;
                                  }else{
                                    controller.addError(error: MyStrings.kMatchPassError);
                                    return;
                                  }
                                }
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FormError(errors: controller.errors),
                            const SizedBox(
                              height: 50,
                            ),
                            controller.isLoading
                                ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ))
                                : RoundedButton(
                              width: 1,
                              text: MyStrings.submit,
                              press: () {
                                controller.resetPassword();
                              },
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

