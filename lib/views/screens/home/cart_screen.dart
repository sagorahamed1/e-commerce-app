import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';

import '../../widgets/custom_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Cart"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: ContainedTabBarView(
            tabBarProperties: TabBarProperties(
              height: 45.h,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              labelStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            ),
            tabs: const [
              Text('                    My Cart                 '),
              Text('           Purchase History          '),
            ],
            views: [
              _buildCartList(),
              Center(child: CustomText(text: "No purchase history yet")),
            ],
            onChange: (index) => print("Tab index changed to $index"),
          ),
        ));
  }

  Widget _buildCartList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
          decoration: BoxDecoration(
            color: const Color(0xfffef4ea), // Card background
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 0), // shadow in all directions
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section

                CustomNetworkImage(
                    borderRadius: BorderRadius.circular(8.r),
                    imageUrl:
                        "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                    height: 139.h,
                    width: 109.w),

                SizedBox(width: 7.w),

                // Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Cat Travel Bag (Used)",
                          fontWeight: FontWeight.w600,
                          bottom: 4.h,
                          color: Colors.black),
                      Row(
                        children: [
                          Assets.icons.moneyIconCard.svg(),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "30\$",
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      CustomText(
                          text: "Pet Type: Cat",
                          fontSize: 12.h,
                          bottom: 4.h,
                          color: Colors.black),
                      CustomText(
                        text: "Condition: Used – 60% Usable",
                        fontSize: 12.h,
                        bottom: 4.h,
                        color: Colors.black,
                      ),
                      CustomText(
                        text: "Location: Banani, Dhaka",
                        fontSize: 12.h,
                        color: Colors.black,
                        bottom: 7.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                                height: 26.h,
                                title: "Offer Price",
                                onpress: () {
                                  TextEditingController amonCtrl =
                                      TextEditingController();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText(
                                                text: "Offer Your Price",
                                                fontSize: 16.h,
                                                fontWeight: FontWeight.w600,
                                                top: 29.h,
                                                bottom: 20.h,
                                                color: Color(0xff592B00)),
                                            Divider(),
                                            SizedBox(height: 12.h),
                                            CustomTextField(
                                                controller: amonCtrl,
                                                labelText: "Enter Amount",
                                                hintText: "Enter Amount"),
                                            SizedBox(height: 12.h),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomButton(
                                                      height: 26.h,
                                                      title: "Cancel",
                                                      onpress: () {},
                                                      color: Colors.transparent,
                                                      fontSize: 11.h,
                                                      loaderIgnore: true,
                                                      boderColor: AppColors
                                                          .primaryColor,
                                                      titlecolor: AppColors
                                                          .primaryColor),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomButton(
                                                      loading: false,
                                                      loaderIgnore: true,
                                                      height: 26.h,
                                                      title: "Offer",
                                                      onpress: () {
                                                        Get.toNamed(AppRoutes.messageScreen);
                                                      },
                                                      fontSize: 11.h),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                color: Colors.transparent,
                                fontSize: 11.h,
                                loaderIgnore: true,
                                boderColor: AppColors.primaryColor,
                                titlecolor: AppColors.primaryColor),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                                loading: false,
                                loaderIgnore: true,
                                height: 26.h,
                                title: "Purchase",
                                onpress: () {},
                                fontSize: 11.h),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
