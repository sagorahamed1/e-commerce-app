import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          children: [
            SizedBox(height: 136.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.profileInformationScreen);
              },
              child: CustomNetworkImage(
                imageUrl: "https://i.pravatar.cc/150?img=3",
                height: 85.h,
                width: 85.w,
                boxShape: BoxShape.circle,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.profileInformationScreen);
              },
              child: CustomText(
                top: 10.h,
                  text: "Syto",
                  fontSize: 24.h,
                  color: Color(0xff592B00),
                  bottom: 48.h),
            ),


            _customCart(
              title: "Profile Information",
              icon: Assets.icons.personalInfoIcon.svg(),
              onTap: () {
                Get.toNamed(AppRoutes.profileInformationScreen);
              },
            ),


            _customCart(
              title: "Wallet",
              icon: Assets.icons.walletIcon.svg(),
              onTap: () {
               Get.toNamed(AppRoutes.walletScreen);
              }),



              _customCart(
                title: "Wish-list",
                icon: Assets.icons.wishListIcon.svg(),
                onTap: () {},
              ),



            _customCart(
              title: "Setting",
              icon: Assets.icons.settingIco.svg(),
              onTap: () {
                Get.toNamed(AppRoutes.settingScreen);
              },
            ),




            _customCart(
              title: "Logout",
              icon: Assets.icons.logout.svg(),
              onTap: () {},
            ),

          ],
        ),
      ),
    );
  }

  Widget _customCart(
      {required String title,
      required Widget icon,
      required VoidCallback onTap}) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Color(0xffFEF3EA),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                icon,
                CustomText(text: "$title", color: Colors.black, left: 16.w),
                Spacer(),
                Assets.icons.rightArrow.svg(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
