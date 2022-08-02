import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/helper/string_format_helper.dart';
import '../../../../../../../core/utils/my_color.dart';
import '../../.././../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../data/controller/payment_log/deposit_controller.dart';
import '../../../../../../data/model/deposit/DepositHistoryMainResponseModel.dart';
import '../../../../../../view/components/buttons/custom_round_border_shape.dart';
import '../../../../../../view/components/buttons/custom_rounded_button.dart';
import '../../../../../../view/components/custom_rounded_icon_button.dart';


class DepositHistoryListItem extends StatelessWidget {
  const DepositHistoryListItem({Key? key,required this.listItem,required this.index,required this.currency}) : super(key: key);
  final Data listItem;
  final int index;
  final String currency;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        margin: Dimensions.lvContainerMargin,
        padding: Dimensions.padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyColor.shimmerBaseColor,
          border: Border.all(color: MyColor.colorBlack2)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(header: 'Tx Id', value: listItem.trx??''),
            const SizedBox(height: 10,),
             const Divider(height: 1,color:  MyColor.colorHint,),
            const SizedBox(height: 10,),
            buildRow(header: 'Plan Name', value: listItem.subscription?.plan?.name??''),
            const SizedBox(height: 10,),
            const Divider(height: 1,color: MyColor.colorHint),
            const SizedBox(height: 10,),
            buildRow(header: 'Gateway', value: listItem.gateway?.name??''),

            const SizedBox(height: 10,),
              const Divider(height: 1,color:  MyColor.colorHint),
            const SizedBox(height: 10,),
            buildRow(header: 'Amount', value: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(listItem.amount??'')} ${listItem.methodCurrency}'),
            const SizedBox(height: 10,),
            const  Divider(height: 1,color:  MyColor.colorHint,),
            const SizedBox(height: 10,),
            buildRow(header: 'Status', value: listItem.status.toString()=='1'?'Complete':listItem.status.toString()=='2'?'Pending':listItem.status.toString()=='3'?'Cancel':'',isStatus: true,status:listItem.status!=null?listItem.status.toString():'1'),
            const SizedBox(height: 10,),
            const  Divider(height: 1,color:  MyColor.colorHint,),
            const SizedBox(height: 10,),
            buildRow(header: 'Date', value: listItem.date??''),
            const SizedBox(height: 10,),
            const  Divider(height: 1,color:  MyColor.colorHint,),
            const SizedBox(height: 10,),
            buildRow(header: '', value: '',isDetails: true),
          ],
        ),
      )
    );

  }

  Widget buildRow({required String header,required String value,bool isStatus=false,bool isDetails=false,String status='3'}){

    Color statusBgColor=MyColor.bgColor;
    Color statusTextColor=status=='1'?MyColor.greenSuccessColor:status=='2'?MyColor.highPriorityPurpleColor:status=='3'?MyColor.closeRedColor:MyColor.secondaryColor2;

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex:2,child: Text(header,style: mulishBold.copyWith(color: MyColor.colorWhite),)),
        isStatus?RoundedBorderContainer(borderColor:Colors.transparent,textColor:statusTextColor,bgColor: statusBgColor,text: value):
        isDetails?
        CustomRoundedButton(horizontalPadding:20,verticalPadding:5,color: MyColor.primaryColor,text: 'Details', press: (){buildDetailsDialog(listItem);}):

        Expanded(flex: 4, child:Text(value,textAlign: TextAlign.end,style: mulishRegular.copyWith(color: MyColor.colorWhite),))
      ],
    );
  }

  void buildDetailsDialog(Data listItem) {
    String siteCurrency=Get.find<DepositController>().currency;
    Get.defaultDialog(
        title: '',
        contentPadding: const EdgeInsets.all(0),
        titlePadding: const EdgeInsets.all(0),
        backgroundColor: MyColor.textFieldColor,
        radius: 10,
        content: Container(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Details',style: mulishBold.copyWith(fontSize: Dimensions.fontLarge,color: MyColor.colorWhite),), SizedBox(height:40,width: 40,child: CustomRoundedIconButton(iconColor:MyColor.colorWhite,color: MyColor.closeRedColor, press: (){Get.back();})),

                ],
              ),
              const SizedBox(height: 8,) ,
              const Divider(height: 1,color: Colors.white54,),
              const SizedBox(height: 8,),
              buildDialogContentRow(header: 'Amount : ', value: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(listItem.amount??'')} $siteCurrency'),
              buildDialogContentRow(header: 'Charge : ', value: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(listItem.charge??'')}$siteCurrency'),
              buildDialogContentRow(header: 'After Charge : ', value: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(listItem.finalAmo??'')}$siteCurrency'),
              buildDialogContentRow(header: 'Conversion Rate : ', value: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(listItem.rate??'')}${listItem.methodCurrency}'),
              buildDialogContentRow(header: 'Payable Amount : ', value: '${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(listItem.finalAmo??'')}${listItem.methodCurrency}'),
            ],
          ),
        )
    );
  }

  Widget buildDialogContentRow({required String header,required String value}){
    return Column(
      children: [
        Row(
          children: [
            Text(header,style: mulishRegular.copyWith(color: MyColor.colorWhite),),
            Expanded(child: Text(value,style: mulishBold.copyWith(color: MyColor.colorWhite),)),
          ],
        ),
        const SizedBox(height: 2,),
      ],
    );
  }
}