import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/controller/chat_list_controller.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/helper/time_format_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/custom_shimmer_listview.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';
import 'package:petattix/views/widgets/no_data_found_card.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';



class MessageUserScreen extends StatefulWidget {
  MessageUserScreen({super.key});

  @override
  State<MessageUserScreen> createState() => _MessageUserScreenState();
}

class _MessageUserScreenState extends State<MessageUserScreen> {
  ChatListController chatListController = Get.put(ChatListController());
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {


    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatListController.chatUsers.value = [];
      chatListController.getChatUser();
    });



    super.initState();
  }

  @override
  void dispose() {
    chatListController.chatUsers.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        iconTheme: IconThemeData(color: Color(0xff592B00)),
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        title: CustomText(
          text: "Chat",
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xff592B00),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            CustomTextField(
              validator: (value) {

              },
                controller: searchCtrl,
                hintextColor: Colors.black87,
                hintText: "Enter name",

                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce!.cancel();
                  debounce = Timer(Duration(milliseconds: 500), () {
                    chatListController.chatUsers.clear();

                    chatListController.getChatUser(search: searchCtrl.text);

                  });
                },


                suffixIcon: Assets.icons.searhIcon.svg()),
            Expanded(
              child: Obx(
                () => chatListController.getChatUserLoading.value
                    ? ShimmerListView(cardHeight: 80.h)
                    : chatListController.chatUsers.isEmpty
                        ? NoDataFoundCard()
                        : ListView.builder(
                            itemCount: chatListController.chatUsers.length,
                            itemBuilder: (context, index) {
                              var chatUser = chatListController.chatUsers[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.messageScreen, arguments: {
                                    "chatId" : chatUser.id.toString(),
                                     "name" : "${chatUser.name}",
                                     "image" : "${chatUser.image}"
                                  })?.then((_){

                                    chatListController.chatUsers.value = [];
                                    chatListController.getChatUser();

                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(3.r),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    color: Color(0xffFEF3EA),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    children: [
                                      CustomNetworkImage(
                                        border: Border.all(
                                            color: Color(0xff592B00),
                                            width: 0.002),
                                        imageUrl:
                                           chatUser.product?.images?.isEmpty ?? false ? "" :  "${ApiConstants.imageBaseUrl}/${chatUser.product?.images?.first.image}",
                                        height: 58.h,
                                        width: 58.w,
                                        boxShape: BoxShape.circle,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        flex: 1000,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              textAlign: TextAlign.start,
                                                text: "${chatUser.name}",
                                                color: Colors.black,
                                                fontSize: 13.h,
                                                fontWeight: FontWeight.w500,
                                                bottom: 6.h),
                                            CustomText(
                                              textAlign: TextAlign.start,
                                                text: "${chatUser.lastmsg?.msg ?? "N/A"}",
                                                fontSize: 12.h),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      CustomText(text: "${TimeFormatHelper.timeWithAMPMLocalTime(chatUser.updatedAt ?? DateTime.now())}"),
                                      SizedBox(width: 8.w)
                                    ],
                                  ),
                                ),
                              );
                            }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
