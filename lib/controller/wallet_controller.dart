import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/config/app_route.dart';

import '../global/custom_assets/assets.gen.dart';
import '../helper/toast_message_helper.dart';
import '../model/category_model.dart';
import '../model/country_model.dart';
import '../model/product_model.dart';
import '../model/single_product_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../views/widgets/custom_button.dart';
import '../views/widgets/custom_text.dart';

class WalletController extends GetxController {



  RxBool addBalanceLoading = false.obs;

  addBalanceToWallet({required String amount, trxId, required BuildContext context}) async {
    addBalanceLoading(true);

    var body = {
      "amount": int.parse(amount),
      "paymentMethod" :"Stripe",
      "transectionId" : "tran-123456124"
    };

    var response = await ApiClient.postData("${ApiConstants.walletBalanceAdd}", jsonEncode(body));

    if (response.statusCode == 200) {

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
    }
  }










}
