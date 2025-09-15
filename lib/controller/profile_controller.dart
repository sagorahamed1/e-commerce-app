import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_constants.dart';
import 'package:petattix/helper/prefs_helper.dart';

import '../helper/toast_message_helper.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class ProfileController extends GetxController {
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString address = "".obs;
  RxString image = "".obs;
  RxString id = "".obs;

  getLocalData() async {
    firstName.value = await PrefsHelper.getString(AppConstants.firstName);
    lastName.value = await PrefsHelper.getString(AppConstants.lastName);
    email.value = await PrefsHelper.getString(AppConstants.email);
    phone.value = await PrefsHelper.getString(AppConstants.phone);
    address.value = await PrefsHelper.getString(AppConstants.address);
    image.value = await PrefsHelper.getString(AppConstants.image);
    id.value = await PrefsHelper.getString(AppConstants.userId);
  }

  ///===============profile update================<>
  RxBool updateProfileLoading = false.obs;

  profileUpdate(
      {File? image, String? firstName, lastName, String? address, String? phone,required BuildContext context}) async {
    updateProfileLoading(true);
    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("image", image)];

    var body = {
      "firstName": "$firstName",
      "lastName": "$lastName",
      "address": "$address",
      "phone": "$phone"
    };
    var response = await ApiClient.patchMultipartData(
        ApiConstants.profile, body,
        multipartBody: multipartBody);

    print("=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {




      Get.back();
      Get.back();


      await PrefsHelper.setString(AppConstants.firstName, firstName);
      await PrefsHelper.setString(AppConstants.lastName, lastName);
      await PrefsHelper.setString(AppConstants.image, response.body["data"]['image']);
      update();
      ToastMessageHelper.showToastMessage(context, "'Profile Updated Successful'");
      updateProfileLoading(false);
    } else {
      updateProfileLoading(false);
    }
  }
}
