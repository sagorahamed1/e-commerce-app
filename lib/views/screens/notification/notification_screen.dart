
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(text: "Notifications", color: AppColors.textColorSecondary5EAAA8, fontSize: 22.h),
      ),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [



            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color(0xffF4F1EE)
                      ),

                      child: Padding(
                        padding:  EdgeInsets.all(12.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [

                            ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CustomNetworkImage(
                                  height: 60.h,
                                  width: 60.w,
                                  boxShape: BoxShape.circle,
                                  imageUrl: "https://randomuser.me/api/portraits/men/10.jpg",
                                  border: Border.all(color: Colors.grey, width: 0.02),
                                )),

                            SizedBox(width: 12.w),


                            CustomText(text: "Alex invited you to their group.", fontSize: 12.h),

                            Spacer(),

                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 45.h),
                                  child: CustomText(
                                      text: "11:58 PM",
                                      fontSize: 9.h),
                                ))


                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )






          ],
        ),
      ),
    );
  }
}
