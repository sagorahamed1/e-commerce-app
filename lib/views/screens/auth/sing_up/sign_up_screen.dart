import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController confirmPassWordCtrl = TextEditingController();
  RxBool isChecked = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 107.h),

              Assets.images.logo.image(height: 160.h, width: 160.w),

              CustomText(
                  text: "Get Started",
                  fontSize: 32.h,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),

              CustomText(
                  text: "by creating a free account",
                  color: AppColors.textColor767676,
                  bottom: 12.h),

              /// <<< ============><>>> Login text flied  << < ==============>>>


              CustomTextField(
                  controller: emailCtrl,
                  hintText: "Full name",
                  prefixIcon: Assets.icons.user.svg()),

              CustomTextField(
                  controller: emailCtrl,
                  hintText: "Valid email",
                  prefixIcon: Assets.icons.emailIcon.svg(),
                  isEmail: true),

              CustomTextField(
                  controller: emailCtrl,
                  hintText: "Phone number",
                  prefixIcon: Assets.icons.phoneNo.svg()),


              CustomTextField(
                  controller: passWordCtrl,
                  prefixIcon: Assets.icons.lock.svg(),
                  hintText: "New Password",
                  isPassword: true),
              CustomTextField(
                  controller: confirmPassWordCtrl,
                  prefixIcon: Assets.icons.lock.svg(),
                  hintText: "Confirm password",
                  isPassword: true),


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Transform.translate(
                      offset: const Offset(0, -18),
                      child: Checkbox(
                        value: isChecked.value,
                        onChanged: (value) {
                          isChecked.value = value!;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 11.h,
                        ),
                        children: [
                          const TextSpan(text: 'By checking the box you agree to our '),
                          TextSpan(
                            text: 'terms',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Open Terms of Service
                              },
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Conditions.',
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Open Privacy Policy
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),


              CustomButton(title: "Sign up", onpress: () {
                Get.toNamed(AppRoutes.optScreen, arguments: {"screenType" : "Sign up"});
              }),

              SizedBox(height: 16.h),

              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.h,
                  ),
                  children: [
                    const TextSpan(text: 'Already a member?  '),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.logInScreen);
                        },
                    )
                  ],
                ),
              ),

              SizedBox(height: 40.h)
            ],
          ),
        ),
      ),
    );
  }
}
