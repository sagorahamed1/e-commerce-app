

import 'dart:io';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petattix/controller/product_controller.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/helper/currency_get_helper.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import '../../../controller/chat_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../../helper/toast_message_helper.dart';
import '../../../services/api_constants.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final ChatDataController chatController = Get.put(ChatDataController());
  final ProductController productController = Get.put(ProductController());
  var argumentsData = Get.arguments;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool itsMe = true;

  @override
  void initState() {
    // chatController.userActiveOn();
    chatController.listenMessage(argumentsData["chatId"]);
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          chatController.loadMore();
          print("====> scroll bottom");
        }
      }
    });


    super.initState();
  }

  @override
  void dispose() {
    chatController.offSocket(argumentsData["chatId"]);

    // SocketServices socketService = SocketServices();
    // socketService.init();
    // SocketServices();

    _scrollController.dispose();
    super.dispose();
  }

  final List<File> _photos = [];

  Future<void> _addPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _photos.add(File(image.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    chatController.getChatList(id: argumentsData["chatId"]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 8,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.chatProfileScreen, arguments: {
              "id" : chatController.chatMessages.value.receiver?.id,
              "image" : "${ApiConstants.imageBaseUrl}/${chatController.chatMessages.value.receiver?.image}",
              "name" : '${chatController.chatMessages.value.conversation?.name}'
            });
          },
          child: Row(
            children: [
              Obx(
                () => CustomNetworkImage(
                    boxShape: BoxShape.circle,
                    imageUrl:
                        '${ApiConstants.imageBaseUrl}/${chatController.chatMessages.value.receiver?.image}',
                    height: 40.h,
                    width: 40.h),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => CustomText(
                          text:
                              '${chatController.chatMessages.value.conversation?.name}',
                          fontSize: 18.h,
                          left: 10.w),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        actions: [


          PopupMenuButton(itemBuilder: (context) => [
           PopupMenuItem(child: CustomText(text: "New Offer Create"), onTap: () {
             TextEditingController amonCtrl = TextEditingController();
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
                         keyboardType: TextInputType.number,
                           controller: amonCtrl,
                           labelText: "Enter Amount",
                           hintText: "Enter Amount"),
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
                                 loaderIgnore: true,
                                 height: 50.h,
                                 title: "Offer",
                                 onpress: () {

                                   productController.sendOffer(id: chatController.chatMessages.value.conversation?.product?.id.toString() ?? "", price: amonCtrl.text, context:  context);


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
           })
          ])
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return chatController.getChatLoading.value
                  ? SizedBox() //ShimmerListView(cardHeight: 60.h)
                  : ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: chatController.chatMessages.value.messages?.length,
                      itemBuilder: (context, index) {
                        if (index <
                            chatController.chatMessages.value.messages!.length) {
                          final message = chatController.chatMessages.value.messages?[index];
                          print("--================================${message?.type}");


                          return Column(
                            crossAxisAlignment: message?.senderId != chatController.chatMessages.value.receiver?.id
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12.h,
                              ),
                              message?.type.toString().toLowerCase() ==
                                      "image"
                                  ? BubbleNormalImage(
                                      isSender: true,
                                      //message?.senderId == message?.senderId,
                                      id: 'id001',
                                      image: CustomNetworkImage(
                                          imageUrl:
                                              "${ApiConstants.imageBaseUrl}/${message?.attachments}",
                                          height: 150,
                                          width: 150),
                                      color: Colors.transparent,
                                      tail: message?.senderId != chatController.chatMessages.value.receiver?.id,
                                      delivered: true)
                                  : message?.type.toString().toLowerCase() ==
                                          "text"
                                      ? BubbleNormal(
                                          text: "${message?.msg}",
                                          isSender: message?.senderId !=
                                              chatController.chatMessages.value
                                                  .receiver?.id,
                                          color: message?.senderId !=
                                                  chatController.chatMessages
                                                      .value.receiver?.id
                                              ? Colors.blue
                                              : const Color(0xff202B33),
                                          tail: message?.senderId !=
                                              chatController.chatMessages.value
                                                  .receiver?.id,
                                          textStyle: TextStyle(
                                            color: message?.senderId !=
                                                    chatController.chatMessages
                                                        .value.receiver?.id
                                                ? Colors.white
                                                : Colors.white,
                                            fontSize: 16.h,
                                          ),
                                        )
                                      : customOfferMessage(
                                          price: "${message?.offer?.price}",
                                          title: "${chatController.chatMessages.value.conversation?.name}",
                                          isSender: message?.senderId != chatController.chatMessages.value.receiver?.id,
                                          status: '',
                                          imageUrl:
                                              "${ApiConstants.imageBaseUrl}/${chatController.chatMessages.value.conversation?.product?.images?[0]["image"]}",
                                          buttons: [

                                            message?.offer?.status == "accepted" ?
                                            SizedBox(
                                                width: 100.w,
                                                height: 32.h,
                                                child: CustomButton(
                                                  fontSize: 10.h,
                                                  loaderIgnore: true,
                                                  title:  message?.offer?.buyerId != chatController.chatMessages.value.receiver?.id ? "Purchase" : "Accepted",
                                                  onpress: () {

                                                    if(message?.offer?.buyerId != chatController.chatMessages.value.receiver?.id){
                                                      Get.toNamed(AppRoutes.confirmPurchaseScreen, arguments: {
                                                        "productId" : message?.offer?.productId.toString()
                                                      });
                                                    }else{
                                                      ToastMessageHelper.showToastMessage(context, "You already accepted", title: "info");
                                                    }


                                                    // productController.acceptOrCancel(id: message?.offerId.toString() ?? "", status: "accept", buyerId: message?.offer?.buyerId);
                                                  },
                                                )) :
                                            Row(
                                              children: [
                                                SizedBox(
                                                    height: 32.h,
                                                    width: 100.w,
                                                    child: CustomButton(
                                                        title: chatController.chatMessages.value.receiver?.id == message?.offer?.buyerId ?  "Reject" : "Cancel",
                                                        color: Colors.transparent,
                                                        titlecolor: AppColors.primaryColor,
                                                        loaderIgnore: true,
                                                        fontSize: 10.h,
                                                        onpress: () {
                                                          if(chatController.chatMessages.value.receiver?.id == message?.offer?.buyerId){

                                                          }else{
                                                            productController.acceptOrCancel(id: message?.offerId.toString() ?? "", status: "reject", buyerId: message?.offer?.buyerId, context: context);
                                                          }
                                                        })),
                                                SizedBox(width: 8.w),

                                                if(chatController.chatMessages.value.receiver?.id == message?.offer?.buyerId)
                                                  SizedBox(
                                                      width: 100.w,
                                                      height: 32.h,
                                                      child: CustomButton(
                                                        fontSize: 10.h,
                                                        loaderIgnore: true,
                                                        title: "Accept",
                                                        onpress: () {
                                                          productController.acceptOrCancel(id: message?.offerId.toString() ?? "", status: "accept", buyerId: message?.offer?.buyerId, context: context);
                                                        },
                                                      ))
                                              ],
                                            )


                                          ]),
                              Align(
                                alignment: message?.senderId != chatController.chatMessages.value.receiver?.id
                                    ? AlignmentDirectional.centerEnd
                                    : Alignment.centerLeft,
                                child: CustomText(
                                    text: TimeAgo.format(
                                        message?.createdAt ?? DateTime.now()),
                                    right: 20.w,
                                    left: 20.w,
                                    fontSize: 12.h),
                              )
                            ],
                          );
                        } else if (index >= chatController.totalResult) {
                          return null;
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
            }),
          ),
          SizedBox(height: 20.h),
          _photos.length != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.w,
                        mainAxisSpacing: 5.h,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: _photos.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _photos.length) {
                          return GestureDetector(
                            onTap: () {
                              if (_photos.length <= 3) {
                                _addPhoto();
                              } else {
                                ToastMessageHelper.showToastMessage(context,
                                    'You cannot select more than four pictures');
                              }
                            },
                          );
                        } else {
                          return Stack(
                            children: [
                              Container(
                                width: 107.w,
                                height: 151.h,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(_photos[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 20.w),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            // chatController.sendMessage(_photos.first,
                            //     argumentsData["receiverId"] // receiverId,
                            // );

                            setState(() {
                              _photos.clear();
                            });
                          },
                        )),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _addPhoto();
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Assets.icons.attachfileIcon.svg(color: Colors.white),
                            )),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 14.h),
                          child: CustomTextField(
                            validator: (value) {},
                            controller: _controller,
                            hintText: 'Type your message...',
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor),
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () {
                              chatController.sendMessage(
                                _controller.text, // message,
                                argumentsData["chatId"],
                              );

                              _controller.clear();
                            },
                          )),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget customOfferMessage({
    required bool isSender,
    required String title,
    required String status,
    required String price,
    required String imageUrl,
    required List<Widget> buttons,
  }) {
    return Container(
      width: 320.w,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isSender ? const Color(0xFFE6E6E6) : Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomNetworkImage(
              height: 90.h,
                width: 48.w,
                imageUrl: "$imageUrl"
            )
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: title,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.h,
                    bottom: 4.h),
                CustomText(text: "Buyer offers you a price", bottom: 4.h, color: Colors.black),
                // CustomText(text: price, bottom: 10.h, color: Color(0xff27A14B)),
                CustomText(text: "Offer Price: ${price} GBP", bottom: 10.h, color: Color(0xff27A14B)),
                Row(
                  children: [...buttons],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
