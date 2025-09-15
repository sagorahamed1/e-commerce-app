import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/controller/auth_controller.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';

import '../../../core/app_constants/app_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  TextEditingController currentPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController rePassCtrl = TextEditingController();

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            CustomTextField(
                controller: currentPassCtrl,
                labelText: "Current Password",
                hintText: "Enter old password",
                isPassword: true,
                contentPaddingVertical: 14.h,
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                filColor: Colors.white),
            CustomTextField(
                controller: newPassCtrl,
                labelText: "New Password",
                hintText: "Enter new password",
                isPassword: true,
                contentPaddingVertical: 14.h,
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                filColor: Colors.white),
            CustomTextField(
                controller: rePassCtrl,
                labelText: "Password",
                hintText: "Re-enter new password",
                isPassword: true,
                contentPaddingVertical: 14.h,
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                filColor: Colors.white,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  Future.delayed(Duration.zero, () => isMatched.value = false);
                  return "Please enter your confirm password";
                } else if (newPassCtrl.text == value) {
                  Future.delayed(Duration.zero, () => isMatched.value = true);
                  return null;
                } else {
                  Future.delayed(Duration.zero, () => isMatched.value = false);
                  return "Password Not Matching";
                }
              },

            ),
            Align(
                alignment: Alignment.centerRight,
                child: CustomText(text: "Forget Password")),
            Spacer(),
            CustomButton(
                title: "Update Password",
                onpress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                                text: "Update password",
                                fontSize: 16.h,
                                fontWeight: FontWeight.w600,
                                top: 20.h,
                                bottom: 12.h,
                                color: Color(0xff592B00)),
                            Divider(),
                            SizedBox(height: 12.h),
                            CustomText(
                              maxline: 2,
                              bottom: 20.h,
                              text: "Do you want to sure change your password?",
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomButton(
                                      height: 50.h,
                                      title: "Cancel",
                                      onpress: () {
                                        Get.back();
                                      },
                                      color: Colors.transparent,
                                      fontSize: 11.h,
                                      loaderIgnore: true,
                                      boderColor: Colors.black,
                                      titlecolor: Colors.black),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  flex: 1,
                                  child: CustomButton(
                                      loading: false,
                                      loaderIgnore: true,
                                      height: 50.h,
                                      title: "Yes",
                                      onpress: () {


                                        authController.changePassword(oldPass: currentPassCtrl.text.trim(),
                                            newPass: newPassCtrl.text.trim(),
                                            context: context);

                                      },
                                      fontSize: 11.h),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
            SizedBox(height: 80.h)
          ],
        ),
      ),
    );
  }


  RxBool isMatched = false.obs;
  ismMatchedColor() {isMatched.value = !isMatched.value;}
}
