import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/helper/time_format_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_shimmer_listview.dart';
import 'package:petattix/views/widgets/no_data_found_card.dart';

import '../../../controller/notifications_controller.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsController notificationsController =
      Get.put(NotificationsController());

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    notificationsController.getGetNotifications();
    super.initState();
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notificationsController.loadMore();
        print("load more true");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              child: Obx(
                () => notificationsController.notificationLoading.value
                    ? ShimmerListView(cardHeight: 70.h)
                    : notificationsController.notifications.isEmpty
                        ? NoDataFoundCard()
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                notificationsController.notifications.length +
                                    1,
                            itemBuilder: (context, index) {
                              if (index < notificationsController.notifications.length) {
                                var notification = notificationsController.notifications[index];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.wishListScreen, arguments: {"title" : "Wish List", "type" : "${notification.id}"});
                                    },
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
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBEWcexrgcYJTSBSh5z0rREtTvoACOcFLoow&s",
                                                border: Border.all(
                                                    color: Colors.blueAccent, width: 2),
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
                                                    text: "${notification.msg}",
                                                    fontSize: 12.h),
                                              ),


                                              CustomText(
                                                  text: "${TimeFormatHelper.formatDate(notification.createdAt ?? DateTime.now())}", fontSize: 9.h),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }else if (index >= notificationsController.totalResult) {
                                return null;
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
