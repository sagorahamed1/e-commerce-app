import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_text.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';

class ProductPostSuccessScreen extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String productPrice;

  const ProductPostSuccessScreen({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),

              // Success Icon
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade100,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 90.sp,
                  color: Colors.green,
                ),
              ),

              SizedBox(height: 24.h),

              CustomText(
                text: "Product Posted Successfully!",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                bottom: 12.h,
              ),

              CustomText(
                text:
                "Your product has been submitted for admin approval. Once approved, it will be visible to everyone in the app.",
                fontSize: 14.sp,
                color: Colors.grey.shade700,
                maxline: 3,
                textAlign: TextAlign.center,
                bottom: 28.h,
              ),

              // Product card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: productName,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                bottom: 4.h,
                              ),
                              CustomText(
                                text: productDescription,
                                fontSize: 13.sp,
                                color: Colors.grey.shade700,
                                maxline: 10,
                                textAlign: TextAlign.start,
                                bottom: 6.h,
                              ),
                              CustomText(
                                text: "Price: $productPrice",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Spacer(),

              CustomButton(
                title: "Go to Home",
                onpress: () {
                  // Get.toNamed(AppRoutes.bottomNavBar);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BottomNavBar();
                  }));
                },
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}