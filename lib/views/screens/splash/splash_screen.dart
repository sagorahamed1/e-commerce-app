import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/config/app_route.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      return Get.offAllNamed(AppRoutes.onboardingScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 250.h),
              Assets.images.logo.image(height: 200.h, width: 200.w),
              CustomText(
                  text: "Buy & Sell Pet Accessories With Ease",
                  fontWeight: FontWeight.w500,
                  top: 20.h,
                  bottom: 139.h),
              Assets.lottie.loading.lottie(height: 60.h)
            ],
          ),
        ),
      ),
    );
  }
}
