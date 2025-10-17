import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import '../model/couriar_service_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../views/screens/bottom_nav_bar/bottom_nav_bar.dart';

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

    if (response.statusCode == 200 || response.statusCode == 201) {
      createDeliveryLoading(false);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BottomNavBar();
      }));

      ToastMessageHelper.showToastMessage(context, response.body["message"]);
    } else {


      print("===========body ${response.body}");
      createDeliveryLoading(false);
      // ToastMessageHelper.showToastMessage(context, response.body["message"].toString(), title: "info");

      ToastMessageHelper.showToastMessage(
          context, response.body["message"],
          title: "info"
      );
      if(response.body["message"] ==  "You don't have enough balance to purchase the product."){

        Get.toNamed(AppRoutes.walletScreen);
      }
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




  RxBool createCollectionLoading = false.obs;

  createCollection(
      {required var data,required String productId,
        required BuildContext context}) async {
    createCollectionLoading(true);


    var response = await ApiClient.postData(
        "${ApiConstants.createCollection(productId)}", jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      createCollectionLoading(false);
      Get.toNamed(AppRoutes.courierScreen, arguments: {
        "productId" : "${productId}"
      });
      ToastMessageHelper.showToastMessage(context, response.body["message"]);
    } else {
      createCollectionLoading(false);
      ToastMessageHelper.showToastMessage(context, response.body["message"], title: "info");

    }
  }






  RxList<CourierServiceModel> couriar = <CourierServiceModel>[].obs;
  RxString quoteId = ''.obs;
  RxBool getCoriarLoading = false.obs;

    geCouriar({required String productId}) async {
      getCoriarLoading(true);
    var response = await ApiClient.postData(ApiConstants.couriar(productId), jsonEncode({}));

    print("=============${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      couriar.value = List<CourierServiceModel>.from(response.body["data"]["ServiceResults"].map((x) => CourierServiceModel.fromJson(x)));

      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // quoteId.value = jsonResponse["data"]["QuoteID"];

      final jsonResponse = response.body; // no jsonDecode
      quoteId.value = jsonResponse["data"]["QuoteID"].toString();


      update();

      getCoriarLoading(false);
    } else {
      getCoriarLoading(false);
    }
  }




  RxBool shipmentLoading = false.obs;

  shipment(
      {required var data,required String productId,
        required BuildContext context}) async {
    shipmentLoading(true);


    var response = await ApiClient.postData(
        "${ApiConstants.shipment(productId)}", jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      shipmentLoading(false);
      Get.back();
      ToastMessageHelper.showToastMessage(context, "${response.body["message"]}");

    } else {
      shipmentLoading(false);
      ToastMessageHelper.showToastMessage(context, response.body["message"], title: "info");

    }
  }





}
