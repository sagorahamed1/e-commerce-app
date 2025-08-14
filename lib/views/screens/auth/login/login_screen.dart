import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/controller/auth_controller.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: forKey,
          child: Column(
            children: [
              SizedBox(height: 107.h),

              Assets.images.logo.image(height: 160.h, width: 160.w),

              CustomText(
                text: "Welcome Back!",
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 22.h,
                top: 15.h,
                bottom: 10.h,
              ),

              CustomText(
                text: "sign in to access your account",
                color: AppColors.textColor767676,
              ),

              SizedBox(height: 33.h),

              /// <<< ============><>>> Login text flied  << < ==============>>>

              Container(
                height: 590.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                    color: Colors.white),
                child: Column(
                  children: [
                    CustomTextField(
                        controller: emailCtrl,
                        hintText: "Enter your email",
                        isEmail: true),
                    CustomTextField(
                        controller: passWordCtrl,
                        hintText: "Enter your password",
                        isPassword: true),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.h,
                          ),
                          children: [
                            TextSpan(
                              text: 'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.forgotScreen, arguments: {
                                    "email" : emailCtrl.text
                                  });
                                },
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 100.h),
                    Obx(() =>
                       CustomButton(
                         loading: authController.loginLoading.value,
                          title: "Sign in",
                          onpress: () {
                            if (forKey.currentState!.validate()) {

                              authController.logIn(
                                context: context,
                                  email: emailCtrl.text.trim(),
                                  password: passWordCtrl.text.trim());
                            }

                          }),
                    ),
                    SizedBox(height: 24.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13.h,
                        ),
                        children: [
                          const TextSpan(text: 'New Member?  '),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.signUpScreen);
                              },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
