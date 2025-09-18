import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/custom_text.dart';

import '../../../controller/chat_controller.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ChatProfileScreen extends StatefulWidget {
  const ChatProfileScreen({super.key});

  @override
  State<ChatProfileScreen> createState() => _ChatProfileScreenState();
}

class _ChatProfileScreenState extends State<ChatProfileScreen> {

  final ChatDataController chatController = Get.put(ChatDataController());


  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CustomNetworkImage(
                  height: 48.h,
                  width: 48.w,
                  boxShape: BoxShape.circle,
                  imageUrl:
                  "${data["image"]}",
                )),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.w,
                  child: CustomText(
                      maxline: 3,
                      textAlign: TextAlign.start,
                      color: Colors.black,
                      text: "${data["name"]}"),
                ),
              ],
            ),


          ],
        ),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [

            SizedBox(height: 18.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.mediaScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color(0xffFEF4EA)
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                  child: Row(
                    children: [

                      Assets.icons.mediaIcon.svg(),

                      CustomText(text: "Media", color: Colors.black, left: 12.w, fontSize: 16.h)


                    ],
                  ),
                ),
              ),
            ),


            SizedBox(height: 18.h),

            GestureDetector(
              onTap: () {


                TextEditingController reportCtrl = TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                              text: "Are you sure to Report this user?",
                              fontSize: 14.h,
                              fontWeight: FontWeight.w600,
                              top: 29.h,
                              bottom: 20.h,
                              color: Color(0xff592B00)),
                          Divider(),
                          SizedBox(height: 12.h),
                          CustomTextField(
                              controller: reportCtrl,
                              labelText: "Reason of Report",
                              hintText: "Reason"),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                    height: 50.h,
                                    title: "Cancel",
                                    onpress: () {
                                      Get.back();
                                    },
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
                                    height: 50.h,
                                    title: "Report",
                                    onpress: () {

                                      // Get.back();
                                      chatController.reportUser(reportedTo: data["id"], description: reportCtrl.text);


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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xffFEF4EA)
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                  child: Row(
                    children: [

                      Assets.icons.reportUserIcon.svg(),

                      CustomText(text: "Report This User", color: Colors.red, left: 12.w, fontSize: 16.h)


                    ],
                  ),
                ),
              ),
            ),



            SizedBox(height: 18.h),


            // GestureDetector(
            //   onTap: () {
            //
            //
            //
            //     showDialog(
            //       context: context,
            //       builder: (context) {
            //         return AlertDialog(
            //           content: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               CustomText(
            //                   text: "Are you sure to Block this user?",
            //                   fontSize: 14.h,
            //                   fontWeight: FontWeight.w600,
            //                   top: 29.h,
            //                   bottom: 20.h,
            //                   color: Color(0xff592B00)),
            //               Divider(),
            //               SizedBox(height: 12.h),
            //
            //               Row(
            //                 children: [
            //                   Expanded(
            //                     flex: 1,
            //                     child: CustomButton(
            //                         height: 50.h,
            //                         title: "Cancel",
            //                         onpress: () {},
            //                         color: Colors.transparent,
            //                         fontSize: 11.h,
            //                         loaderIgnore: true,
            //                         boderColor: AppColors
            //                             .primaryColor,
            //                         titlecolor: AppColors
            //                             .primaryColor),
            //                   ),
            //                   SizedBox(width: 8.w),
            //                   Expanded(
            //                     flex: 1,
            //                     child: CustomButton(
            //                         loading: false,
            //                         loaderIgnore: true,
            //                         height: 50.h,
            //                         title: "Block",
            //                         onpress: () {
            //                           Get.toNamed(AppRoutes.messageScreen);
            //                         },
            //                         fontSize: 11.h),
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //         );
            //       },
            //     );
            //
            //
            //
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10.r),
            //         color: Color(0xffFEF4EA)
            //     ),
            //
            //     child: Padding(
            //       padding:  EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
            //       child: Row(
            //         children: [
            //
            //           Assets.icons.blockUserIcon.svg(),
            //
            //           CustomText(text: "Block This User", color: Colors.red, left: 12.w, fontSize: 16.h)
            //
            //
            //         ],
            //       ),
            //     ),
            //   ),
            // )




          ],
        ),
      ),


    );
  }
}
