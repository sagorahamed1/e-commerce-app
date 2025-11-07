import 'dart:convert';

import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:petattix/core/app_constants/app_constants.dart';
import 'package:petattix/helper/prefs_helper.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:petattix/services/api_client.dart';
import 'package:petattix/services/api_constants.dart';

import '../core/config/app_route.dart';
import '../services/socket_services.dart';

class AuthController extends GetxController {
  RxBool signUpLoading = false.obs;

  signUp(
      {required String firstName,
        countryCode,
      lastName,
      email,
      phone,
      address,
      password,required BuildContext context}) async {
    signUpLoading(true);


    print("====================${countryCode}");

    final code = countryCode.replaceAll("+", "");
    final country = CountryPickerUtils.getCountryByPhoneCode(code);

    print("====================${country.currencyCode}");
    print("====================${country.currencyName}");
    print("====================${country.name}");


    var body = {
      "firstName": "$firstName",
      "lastName": "$lastName",
      "email": "${email}",
      "address": "$address, ${country.name}",
      "phone": "$phone",
      "password": "$password",
      "currency" : "${country.currencyCode.toString()}"
    };




    final response =
        await ApiClient.postData(ApiConstants.signUpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      PrefsHelper.setString(AppConstants.userId, response.body["user"]["id"]);
      PrefsHelper.setString(AppConstants.bearerToken, response.body["token"]);
      Get.toNamed(AppRoutes.optScreen, arguments: {"screenType": "Sign up"});

      signUpLoading(false);
      ToastMessageHelper.showToastMessage(context, response.body["message"]);
    } else {
      signUpLoading(false);
      ToastMessageHelper.showToastMessage(context, response.body["message"], title: "error");
    }
  }

  RxBool loginLoading = false.obs;

  logIn({required String email, password, required BuildContext context}) async {
    await PrefsHelper.remove(AppConstants.bearerToken);


    loginLoading(true);
    var body = {"email": "$email", "password": "$password"};

    var header = {
      'Content-Type': 'application/json'
    };

    final response = await ApiClient.postData(ApiConstants.loginEndPoint, jsonEncode(body), headers: header);

    if (response.statusCode == 200 || response.statusCode == 201) {

      var data = response.body;
      PrefsHelper.setString(AppConstants.userId, data["data"]["id"]);
      PrefsHelper.setString(AppConstants.firstName, data["data"]["firstName"]);
      PrefsHelper.setString(AppConstants.lastName, data["data"]["lastName"]);
      PrefsHelper.setString(AppConstants.email, data["data"]["email"]);
      PrefsHelper.setString(AppConstants.address, data["data"]["address"]);
      PrefsHelper.setString(AppConstants.currency, data["data"]["currency"] ?? "gbp");
      PrefsHelper.setString(AppConstants.phone, data["data"]["phone"]);
      PrefsHelper.setString(AppConstants.role, data["data"]["roles"][0]);
      PrefsHelper.setString(AppConstants.bearerToken, data["token"]);
      PrefsHelper.setBool(AppConstants.isLogged, true);

      Get.offAllNamed(AppRoutes.welcomeScreen);
      loginLoading(false);

      PrefsHelper.setString(AppConstants.image, data["data"]["image"]);


      SocketServices.init(token: data["token"]);

    } else {
      loginLoading(false);
      PrefsHelper.setString(AppConstants.bearerToken, response.body["token"]);
      ToastMessageHelper.showToastMessage(context, response.body["message"], title: "info");

      if(response.body["message"] == "Email verification required"){
        Get.toNamed(AppRoutes.optScreen, arguments: {"screenType": "Sign up"});
      }

    }
  }

  RxBool verifyEmailLoading = false.obs;

  verifyEmail({required String otp, verifyType}) async {
    verifyEmailLoading(true);
    String userId = await PrefsHelper.getString(AppConstants.userId);
    var body = {
      "user_id": "$userId",
      "otp": "$otp",
      "verification_type": verifyType == "forgot" ? "forgot_password" : "registration"
    };

    final response =
        await ApiClient.postData(ApiConstants.emailVerify, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (verifyType == "sign up") {

          Get.toNamed(AppRoutes.setDropOffLocationScreen, arguments: {
            "screenType" : "signup"
          });

      } else {
        Get.toNamed(AppRoutes.resetPasswordScreen);
      }
    } else {
      verifyEmailLoading(false);
    }
  }




  RxBool forgotLoading = false.obs;

  forgetPassword({required String email}) async {
    forgotLoading(true);

    var body = {"email": "$email"};

    final response =
        await ApiClient.postData(ApiConstants.forgotPassword, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      PrefsHelper.setString(AppConstants.bearerToken, response.body["token"]);
      Get.toNamed(AppRoutes.optScreen, arguments: {"screenType": "forget"});

      forgotLoading(false);
    } else {
      forgotLoading(false);
    }
  }




  RxBool reSetPasswordLoading = false.obs;

  resetPassword({required String newPassword, confirmPassword}) async {
    reSetPasswordLoading(true);

    var body = {"password": "$newPassword", "passwordConfirm" : "$confirmPassword"};

    final response =
    await ApiClient.postData(ApiConstants.resetPassword, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.logInScreen);

      reSetPasswordLoading(false);
    } else {
      reSetPasswordLoading(false);
    }
  }



  RxBool changeLoading = false.obs;

  changePassword({required String oldPass, newPass,required BuildContext context}) async {
    changeLoading(true);

    var body = {
      "passwordCurrent":"$oldPass",
      "password":"$newPass",
      "passwordConfirm":"$newPass"
    };

    final response =
    await ApiClient.postData(ApiConstants.updatePassword, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {

      Get.back();

      ToastMessageHelper.showToastMessage(context, "${response.body["message"]}");

      changeLoading(false);
    } else {
      changeLoading(false);
      ToastMessageHelper.showToastMessage(context, "${response.body["message"]}", title: "warning");
    }
  }




  RxBool setDropOfLocationLoading = false.obs;

  setDropOfLocation({required var data, String? screenType}) async {
    setDropOfLocationLoading(true);

    final response =
    await ApiClient.patch(ApiConstants.dropOffLocation, jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {



      if(screenType ==  "edit"){
        Get.back();
        Get.back();
      }else{

        await PrefsHelper.remove(AppConstants.bearerToken);
        Get.offAllNamed(AppRoutes.logInScreen);
      }



      setDropOfLocationLoading(false);
    } else {
      setDropOfLocationLoading(false);
    }
  }


}
