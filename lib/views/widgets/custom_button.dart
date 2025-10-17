import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/helper/toast_message_helper.dart';
import '../../core/app_constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import '../../main.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final Color? color;
  final Color? boderColor;
  final Color? titlecolor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool loading;
  final bool loaderIgnore;
  final bool isInternetNeed;
  final Widget? leftIcon;

  CustomButton({
    super.key,
    required this.title,
    required this.onpress,
    this.color,
    this.boderColor,
    this.height,
    this.width,
    this.fontSize,
    this.titlecolor,
    this.leftIcon,
    this.loading=false,
    this.loaderIgnore = false, this.fontWeight, this.borderRadius, this.isInternetNeed = false,
  });

  @override
  Widget build(BuildContext context) {
    final connectivityService = Get.find<ConnectivityService>();

      final isConnected = connectivityService.isConnected.value;

    return GestureDetector(
      onTap: loading?(){} : (){

        if(isConnected){
          onpress();
        }else if(!isInternetNeed){
          onpress();
        }else{
          ToastMessageHelper.showToastMessage(context, "Please check your internet!", title: "Warning");
        }

      },
      child: Container(
        width:width?.w ?? double.infinity,
        height: height ?? 50.h,
        padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(borderRadius ?? 16.r),
          border: Border.all(color: boderColor ?? AppColors.primaryColor),
          color: color ?? AppColors.primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

           loaderIgnore ? const SizedBox() : SizedBox(width: 30.w),

            SizedBox(child: leftIcon ?? SizedBox.shrink()),

            Center(
              child: CustomText(
                text: title,
                fontSize: fontSize ?? 16.h,
                color: titlecolor ?? Colors.white,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
            ),


            loaderIgnore ? const SizedBox() :  SizedBox(width: 20.w),


            loaderIgnore ? const SizedBox() :  loading  ?
                SizedBox(
                    height: 40.h,
                    width: 25.w,
                    child: Assets.lottie.loading.lottie(fit: BoxFit.cover)
                ) :  SizedBox(width: 20.w)
          ],
        ),
      ),
    );
  }
}