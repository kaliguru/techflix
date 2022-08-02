import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/my_color.dart';

import '../../../../data/controller/deposit_controller/add_new_deposit_controller.dart';
import '../../../../data/repo/auth/general_setting_repo.dart';
import '../../../../data/repo/deposit_repo/deposit_repo.dart';
import '../../../components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/subscribe_plan/add_deposit_screen/body.dart';



class AddDepositScreen extends StatefulWidget {
  const AddDepositScreen({Key? key}) : super(key: key);

  @override
  State<AddDepositScreen> createState() => _AddDepositScreenState();
}

class _AddDepositScreenState extends State<AddDepositScreen> {
  String price='-1';
  String planName='';
  String subscriptionId='-1';
  @override
  void initState() {

    price=Get.arguments[0];
    planName=Get.arguments[1];
    subscriptionId=Get.arguments[2];
    Get.lazyPut(()=>DepositRepo(apiClient: Get.find()));
     Get.lazyPut(()=>AddNewDepositController(depositRepo: Get.find()));
    super.initState();

  }
  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.colorBlack,
          appBar:  const CustomAppBar(title: MyStrings.addPayment,),
          body:  Body(price: price,planName: planName,subscriptionId: subscriptionId,),
        );
  }
}
