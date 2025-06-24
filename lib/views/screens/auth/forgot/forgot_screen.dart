import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Forget Password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),

              Assets.images.logo.image(height: 160.h, width: 160.w),

              CustomText(
                text: "Please enter your email to reset your password.",
                color: AppColors.textColor767676,
                top: 19.h,
                bottom: 43.h,
              ),

              /// <<< ============><>>> Login text flied  << < ==============>>>

              CustomTextField(
                controller: emailCtrl,
                hintText: "Enter your email",
                isEmail: true,
                prefixIcon: Assets.icons.emailIcon.svg(),
              ),

              SizedBox(height: 120.h),

              CustomButton(
                  title: "Get Verification Code",
                  onpress: () {
                    Get.toNamed(AppRoutes.optScreen,
                        arguments: {"screenType": "forget"});
                  }),

              SizedBox(height: 160.h)
            ],
          ),
        ),
      ),
    );
  }
}
