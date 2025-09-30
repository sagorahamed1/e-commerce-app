import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/controller/auth_controller.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class OptScreen extends StatelessWidget {
  OptScreen({super.key});

  final TextEditingController pinCtrl = TextEditingController();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Verify"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              Assets.images.logo.image(height: 160.h, width: 160.w),

              CustomText(
                text:
                    "Please enter the verification code sent to \n your e-mail",
                color: AppColors.textColor767676,
                top: 19.h,
                bottom: 21.h,
              ),

              /// <<< ============><>>> Login text flied  << < ==============>>>

              Column(
                children: [
                  // TODO: Pin Code TextField

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.w),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: pinCtrl,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 60,
                        fieldWidth: 60,
                        inactiveColor: AppColors.borderColor,
                        selectedColor: AppColors.borderColor,
                        activeColor: AppColors.borderColor,
                        disabledColor: AppColors.borderColor,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: false,
                      onChanged: (value) {},
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Didn't get the code?"),
                      GestureDetector(
                          onTap: (){

                          },
                          child: CustomText(text: "Resend", color: AppColors.primaryColor))
                    ],
                  ),

                  SizedBox(height: 120.h),

                  Obx(() =>
                     CustomButton(
                       loading: authController.verifyEmailLoading.value,
                        title: "Get Verification Code",
                        onpress: () {
                          if (pinCtrl.text == "") {
                            ToastMessageHelper.showToastMessage(
                              context,
                                "Please enter otp code");
                          } else {
                            Get.arguments["screenType"] == "Sign up"
                                ? authController.verifyEmail(otp: pinCtrl.text, verifyType: "sign up")

                                : authController.verifyEmail(otp: pinCtrl.text, verifyType: "forgot");
                          }
                        }),
                  ),
                  SizedBox(height: 160.h),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
