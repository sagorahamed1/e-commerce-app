import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:petattix/helper/toast_message_helper.dart';

import '../../../../controller/auth_controller.dart';
import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController countryCodeCtrl = TextEditingController();
  final TextEditingController completedNumberCtrl = TextEditingController();
  final TextEditingController confirmPassWordCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  RxBool isChecked = false.obs;
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: forKey,
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
                    controller: firstNameCtrl,
                    hintText: "first name",
                    prefixIcon: Assets.icons.user.svg()),


                CustomTextField(
                    controller: lastNameCtrl,
                    hintText: "last name",
                    prefixIcon: Assets.icons.user.svg()),

                CustomTextField(
                    controller: emailCtrl,
                    hintText: "Valid email",
                    prefixIcon: Assets.icons.emailIcon.svg(),
                    isEmail: true),

                CustomTextField(
                    controller: addressCtrl,
                    hintText: "Address",
                    prefixIcon: Assets.icons.aboutUs.svg()),

                IntlPhoneField(
                  controller: numberCtrl,
                  decoration: InputDecoration(
                    labelText: '',
                    fillColor: Color(0xffFFF2E6),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.05)),
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.05)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.05)),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'US',
                  // Default country
                  onChanged: (phone) {
                    completedNumberCtrl.text = phone.completeNumber;
                    countryCodeCtrl.text = phone.countryCode;
                    print(phone.completeNumber); // e.g. +14155552671
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  },
                ),

                CustomTextField(
                    controller: passWordCtrl,
                    prefixIcon: Assets.icons.lock.svg(),
                    hintText: "Password",
                    isPassword: true),
                CustomTextField(
                    controller: confirmPassWordCtrl,
                    prefixIcon: Assets.icons.lock.svg(),
                    hintText: "Re-enter password",
                    isPassword: true,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      Future.delayed(Duration.zero, () => isMatched.value = false);
                      return "Please enter your confirm password";
                    } else if (passWordCtrl.text == value) {
                      Future.delayed(Duration.zero, () => isMatched.value = true);
                      return null;
                    } else {
                      Future.delayed(Duration.zero, () => isMatched.value = false);
                      return "Password Not Matching";
                    }
                  },

                ),

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
                            const TextSpan(
                                text: 'By checking the box you agree to our '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Open Terms of Service
                                  Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                                    "title" : "Privacy Policy",
                                  });
                                },
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Terms & Conditions.',
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Open Privacy Policy
                                  Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                                    "title" : "Terms of service",
                                  });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Obx(
                  () => CustomButton(
                      loading: authController.signUpLoading.value,
                      title: "Sign up",
                      onpress: () {
                        if (forKey.currentState!.validate()) {
                          ///TODO: API CALLING
                          if (isChecked.value) {
                            authController.signUp(
                                firstName: firstNameCtrl.text,
                                lastName: lastNameCtrl.text,
                                phone: completedNumberCtrl.text,
                                address: addressCtrl.text,
                                password: passWordCtrl.text.trim(),
                                email: emailCtrl.text.trim(),
                               countryCode:  countryCodeCtrl.text ,
                               context: context
                            );
                          } else {
                            authController.signUpLoading(false);
                            print("dkdkdkkfjadsfkajsflaksjdfkldasjfk");
                            ToastMessageHelper.showToastMessage(
                              context, "Please Accept Privacy Policy and Terms & Conditions", title: "Warning");
                          }
                        }
                        //
                      }),
                ),

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
      ),
    );
  }



  RxBool isMatched = false.obs;
  ismMatchedColor() {isMatched.value = !isMatched.value;}
}
