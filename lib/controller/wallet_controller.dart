import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:petattix/model/wallet_history_model.dart';
import '../global/custom_assets/assets.gen.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../views/screens/profile/withdraw_success_screen.dart';
import '../views/widgets/custom_button.dart';
import '../views/widgets/custom_text.dart';

class WalletController extends GetxController {



  RxBool addBalanceLoading = false.obs;

  addBalanceToWallet({required String amount, trxId, paymentIntentId, required BuildContext context}) async {
    addBalanceLoading(true);

    var body = {
      "amount": int.parse(amount),
      "paymentMethod" :"Stripe",
      "transectionId" : "$trxId",
      "paymentId" : "$paymentIntentId"
    };

    var response = await ApiClient.postData("${ApiConstants.walletBalanceAdd}", jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                  Center(
                      child: Column(
                        children: [
                          Assets.icons.confirmationIcon.svg(
                            height: 124.h,
                            width: 124.w,
                          ),
                          CustomText(
                            text: 'Payment Success',
                            fontSize: 22.sp,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomText(
                            text: 'Your payment has been processed successfully',
                            fontSize: 13.sp,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomButton(
                            onpress: () {

                              Get.back();
                              WalletController walletController = Get.put(WalletController());
                              walletController.walletHistory.value = [];
                              walletController.getBalance();
                              walletController.getWallet();

                            },
                            title: 'Go To Wallet',
                          ),
                        ],
                      ))
                ],
              ),
            );
          });

      addBalanceLoading(false);
    } else {
      addBalanceLoading(false);
      if(int.parse(amount) < 10){
        ToastMessageHelper.showToastMessage(context, "Minimum 10 Pounds required", title: "Warning");
      }else{
        ToastMessageHelper.showToastMessage(context, "Add Balance Failed! \n Try again", title: "Warning");
      }

    }
  }



  RxList<WalletHistoryModel> walletHistory = <WalletHistoryModel>[].obs;

  RxBool walletLoading = false.obs;
  getWallet()async{
    walletLoading(true);

    final response = await ApiClient.getData(ApiConstants.walletHistory);

    if(response.statusCode == 200 || response.statusCode == 201){

      walletHistory.value = List<WalletHistoryModel>.from(response.body["data"].map((x) => WalletHistoryModel.fromJson(x)));
      walletLoading(false);
    }else{
      walletLoading(false);
    }
  }







  RxString balance = '0'.obs;
  RxBool balanceLoading = false.obs;
  getBalance()async{
    balanceLoading(true);

    final response = await ApiClient.getData(ApiConstants.balance);

    if(response.statusCode == 200 || response.statusCode == 201){

      balance.value = response.body["data"]['balance'].toString();
      update();

      balanceLoading(false);
    }else{
      balanceLoading(false);
    }
  }








  RxBool withdrawBalanceLoading = false.obs;

  withdrawBalance({required String amount, required BuildContext context}) async {
    withdrawBalanceLoading(true);

    var body = {
      "amount": int.parse(amount)
    };

    var response = await ApiClient.postData("${ApiConstants.withDraw}", jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {

     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
     //  return  WithdrawSuccessScreen(amount: amount);
     // },));

      Get.toNamed(AppRoutes.withdrawSuccessScreen, arguments: {
        "amount" : amount
      });

      withdrawBalanceLoading(false);
    } else {
      withdrawBalanceLoading(false);


    }
  }




}




