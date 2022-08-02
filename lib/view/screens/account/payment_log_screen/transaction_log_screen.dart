import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/repo/deposit_repo/deposit_repo.dart';
import 'package:play_lab/view/screens/account/payment_log_screen/widget/payment_log_list_item/payment_log_list_item.dart';

import '../../../../constants/my_strings.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/payment_log/deposit_controller.dart';
import '../../../../data/enum/navigation_item.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/CustomNoDataFoundClass.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/nav_drawer/custom_nav_drawer.dart';

class PaymentLogsScreen extends StatefulWidget {
  const PaymentLogsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentLogsScreen> createState() => _PaymentLogsScreenState();
}

class _PaymentLogsScreenState extends State<PaymentLogsScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.find<DepositController>().clearData();
    super.dispose();
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    Get.put(DepositController(depositRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationDrawerWidget.navigationItem = NavigationItem.payment;
      Get.find<DepositController>().beforeInitLoadData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
        builder: (controller) => Scaffold(
              backgroundColor: MyColor.secondaryColor2,
              appBar: const CustomAppBar(
                bgColor: MyColor.secondaryColor2,
                title: MyStrings.payment,
              ),
              body: controller.isLoading
                  ? const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : controller.depositList.isEmpty
                      ? const NoDataFoundScreen(
                          message: 'No Transaction Found',
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              buildLatestTransactionList(context,controller.currency),
                            ],
                          ),
                        ),
            ));
  }

  buildLatestTransactionList(BuildContext context,String currency) {
    return Expanded(
      child: GetBuilder<DepositController>(
        builder: (controller) => ListView.builder(
            itemCount: controller.depositList.length + 1,
            shrinkWrap: true,
            controller: _controller,
            itemBuilder: (builder, index) {
              if (index == controller.depositList.length) {
                return Center(
                  child: controller.hasNext()
                      ? const CircularProgressIndicator()
                      : const SizedBox(),
                );
              }
              return DepositHistoryListItem(
                  listItem: controller.depositList[index], index: index,currency:currency);
            }),
      ),
    );
  }



  Widget buildRow(
      {required String header, required String value, bool isDetails = false}) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  header,
                  style: mulishSemiBold,
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: mulishSemiBold,
                  textAlign: TextAlign.end,
                ))
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        isDetails
            ? const SizedBox()
            : const Divider(
                height: 1,
                color: MyColor.bodyTextColor,
              )
      ],
    );
  }
}
