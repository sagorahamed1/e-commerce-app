import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_constants.dart';
import 'package:petattix/helper/prefs_helper.dart';

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
    Future.delayed(Duration(seconds: 3), ()async {
      bool isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
      final token = await PrefsHelper.getString(AppConstants.bearerToken);


      if(token != "" && isLogged){
        Get.offAllNamed(AppRoutes.welcomeScreen);
      }else{
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
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
