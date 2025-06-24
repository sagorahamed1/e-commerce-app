import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController newCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset Password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Assets.images.logo.image(height: 160.h, width: 160.w),

              CustomText(
                  text: "Password  must have 6-8 characters.",
                  color: AppColors.textColor767676,
                  top: 19.h,
                  bottom: 24.h),

              /// <<< ============><>>> Login text flied  << < ==============>>>

              CustomTextField(
                  controller: newCtrl,
                  hintText: "New password",
                  prefixIcon: Assets.icons.lock.svg(),
                  isPassword: true),
              CustomTextField(
                  controller: confirmPassCtrl,
                  hintText: "Confirm password",
                  prefixIcon: Assets.icons.lock.svg(),
                  isPassword: true),

              SizedBox(height: 130.h),

              CustomButton(title: "Confirm", onpress: () {}),

              SizedBox(height: 160.h)
            ],
          ),
        ),
      ),
    );
  }
}
