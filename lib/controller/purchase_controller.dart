import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class PurchaseController extends GetxController {
  RxBool createDeliveryLoading = false.obs;

  createDelivery(
      {required String companyName,
      addressOne,
      addressTow,
      city,
      postCode,
      phoneNumber,
      countryId,
      countryCode,
      country,
      productId,
      required BuildContext context}) async {
    createDeliveryLoading(true);

    var body = {
      "companyName": "$companyName",
      "addressLineOne": "${addressOne}",
      "addressLineTwo": "$addressTow",
      "city": '$city',
      "postcode": "$postCode",
      "telephoneNumber": "$phoneNumber",
      "country_id": int.parse(countryId),
      "country_code": "$countryCode",
      "country": "$country"
    };

    var response = await ApiClient.postData(
        "${ApiConstants.createDelivery}/${productId}", jsonEncode(body));

    if (response.statusCode == 200) {
      createDeliveryLoading(false);
    } else {
      createDeliveryLoading(false);
    }
  }

  RxString balance = ''.obs;
  RxBool balanceLoading = false.obs;

  getBalance() async {
    balanceLoading(true);

    final response = await ApiClient.getData(ApiConstants.balance);

    if (response.statusCode == 200 || response.statusCode == 201) {
      balance.value = response.body["data"]['balance'].toString();
      update();

      balanceLoading(false);
    } else {
      balanceLoading(false);
    }
  }
}
