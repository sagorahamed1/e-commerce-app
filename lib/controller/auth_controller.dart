import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:petattix/core/app_constants/app_constants.dart';
import 'package:petattix/helper/prefs_helper.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:petattix/services/api_client.dart';
import 'package:petattix/services/api_constants.dart';

import '../core/config/app_route.dart';

class AuthController extends GetxController {
  RxBool signUpLoading = false.obs;

  signUp(
      {required String firstName,
      lastName,
      email,
      phone,
      address,
      password}) async {
    signUpLoading(true);
    var body = {
      "firstName": "$firstName",
      "lastName": "$lastName",
      "email": "${email}",
      "address": "$address",
      "phone": "$phone",
      "password": "$password"
    };
    final response =
        await ApiClient.postData(ApiConstants.signUpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      PrefsHelper.setString(AppConstants.userId, response.body["user"]["id"]);
      PrefsHelper.setString(AppConstants.bearerToken, response.body["token"]);
      Get.toNamed(AppRoutes.optScreen, arguments: {"screenType": "Sign up"});

      signUpLoading(false);
    } else {
      signUpLoading(false);
    }
  }

  RxBool loginLoading = false.obs;

  logIn({required String email, password, required BuildContext context}) async {
    await PrefsHelper.remove(AppConstants.bearerToken);
    loginLoading(true);
    var body = {"email": "$email", "password": "$password"};
    final response = await ApiClient.postData(ApiConstants.loginEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.welcomeScreen);
      loginLoading(false);
    } else {
      ToastMessageHelper.showToastMessage(context, response.body["message"]);
      loginLoading(false);
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
        await PrefsHelper.remove(AppConstants.bearerToken);
          Get.toNamed(AppRoutes.logInScreen);
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

  resetPassword({required String email}) async {
    reSetPasswordLoading(true);

    var body = {"email": "$email"};

    final response =
    await ApiClient.postData(ApiConstants.forgotPassword, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.logInScreen);

      reSetPasswordLoading(false);
    } else {
      reSetPasswordLoading(false);
    }
  }
}
