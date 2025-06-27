import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notifications"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CustomNetworkImage(
                                height: 56.h,
                                width: 56.w,
                                boxShape: BoxShape.circle,
                                imageUrl:
                                    "https://randomuser.me/api/portraits/men/10.jpg",
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 2),
                              )),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.w,
                                child: CustomText(
                                    maxline: 3,
                                    textAlign: TextAlign.start,
                                    color: Colors.black,
                                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                                    fontSize: 12.h),
                              ),


                              CustomText(
                                  text: "11:58 PM", fontSize: 9.h),
                            ],
                          ),


                        ],
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
