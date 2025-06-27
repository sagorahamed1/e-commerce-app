import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text.dart';

class Confirmed extends StatelessWidget {
  const Confirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Confirmed"),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [


            SizedBox(height: 200.h),

            Assets.images.confirmImage.image(height: 150.h, width: 150.w),

            CustomText(text: "Order Confirmed", color: AppColors.primaryColor, fontSize: 20.h),


            CustomText(text: "Your order has been placed Successfully.", color: Colors.black, fontSize: 16.h),



            Spacer(),

            CustomButton(title: "View Order", onpress: (){}),


            SizedBox(height: 100.h)

          ],
        ),
      ),
    );
  }
}
