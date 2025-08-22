// import 'package:chatview/chatview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:petattix/core/app_constants/app_colors.dart';
// import 'package:petattix/core/config/app_route.dart';
// import 'package:petattix/views/widgets/custom_button.dart';
// import 'package:petattix/views/widgets/custom_text.dart';
//
// import '../../../controller/chat_controller.dart';
//
// class MessageScreen extends StatefulWidget {
//   const MessageScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MessageScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<MessageScreen> {
//   bool isDarkTheme = false;
//   late final ChatController _chatController;
//   ChatDataController controller = Get.put(ChatDataController());
//
//   @override
//   void initState() {
//     super.initState();
//     _chatController = ChatController(
//       initialMessageList: controller.chatMessages
//           .map((chat) => Message(
//               message: chat.id.toString(),
//               createdAt: chat.createdAt ?? DateTime.now(),
//               sentBy: chat.senderId.toString()))
//           .toList(),
//       scrollController: ScrollController(),
//       currentUser: const ChatUser(
//         id: '1',
//         name: 'Flutter',
//         profilePhoto: Data.profileImage,
//       ),
//       otherUsers: const [],
//     );
//   }
//
//   @override
//   void dispose() {
//     _chatController.dispose();
//     super.dispose();
//   }
//
//   void receiveMessage() async {
//     _chatController.addMessage(
//       Message(
//         id: DateTime.now().toString(),
//         message: 'I will schedule the meeting.',
//         createdAt: DateTime.now(),
//         sentBy: '2',
//       ),
//     );
//     await Future.delayed(const Duration(milliseconds: 500));
//     _chatController.addReplySuggestions([
//       const SuggestionItemData(text: 'Thanks.'),
//       const SuggestionItemData(text: 'Thank you very much.'),
//       const SuggestionItemData(text: 'Great.')
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ChatView(
//         chatController: _chatController,
//         onSendTap: _onSendTap,
//         featureActiveConfig: const FeatureActiveConfig(
//           lastSeenAgoBuilderVisibility: true,
//           receiptsBuilderVisibility: true,
//           enableScrollToBottomButton: true,
//         ),
//         scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
//           backgroundColor: theme.textFieldBackgroundColor,
//           border: Border.all(
//             color: isDarkTheme ? Colors.transparent : Colors.grey,
//           ),
//           icon: Icon(
//             Icons.keyboard_arrow_down_rounded,
//             color: theme.themeIconColor,
//             weight: 10,
//             size: 30,
//           ),
//         ),
//         chatViewState: ChatViewState.hasMessages,
//         chatViewStateConfig: ChatViewStateConfiguration(
//           loadingWidgetConfig: ChatViewStateWidgetConfiguration(
//             loadingIndicatorColor: theme.outgoingChatBubbleColor,
//           ),
//           onReloadButtonTap: () {},
//         ),
//         typeIndicatorConfig: TypeIndicatorConfiguration(
//           flashingCircleBrightColor: theme.flashingCircleBrightColor,
//           flashingCircleDarkColor: theme.flashingCircleDarkColor,
//         ),
//         appBar: GestureDetector(
//           onTap: () {
//             Get.toNamed(AppRoutes.chatProfileScreen);
//           },
//           child: ChatViewAppBar(
//             elevation: theme.elevation,
//             backGroundColor: theme.appBarColor,
//             profilePicture: Data.profileImage,
//             backArrowColor: theme.backArrowColor,
//             chatTitle: "Cat Travel Bag (Sagor)",
//             chatTitleTextStyle: TextStyle(
//               color: theme.appBarTitleTextStyle,
//               fontWeight: FontWeight.bold,
//               fontSize: 14.h,
//               letterSpacing: 0.25,
//             ),
//             userStatus: "last active 23 hr ago",
//             userStatusTextStyle: const TextStyle(color: Colors.grey),
//             actions: [
//               // IconButton(
//               //   onPressed: _onThemeIconTap,
//               //   icon: Icon(
//               //     isDarkTheme
//               //         ? Icons.brightness_4_outlined
//               //         : Icons.dark_mode_outlined,
//               //     color: theme.themeIconColor,
//               //   ),
//               // ),
//               // IconButton(
//               //   tooltip: 'Toggle TypingIndicator',
//               //   onPressed: _showHideTypingIndicator,
//               //   icon: Icon(
//               //     Icons.keyboard,
//               //     color: theme.themeIconColor,
//               //   ),
//               // ),
//               // IconButton(
//               //   tooltip: 'Simulate Message receive',
//               //   onPressed: receiveMessage,
//               //   icon: Icon(
//               //     Icons.supervised_user_circle,
//               //     color: theme.themeIconColor,
//               //   ),
//               // ),
//
//               IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
//             ],
//           ),
//         ),
//         chatBackgroundConfig: ChatBackgroundConfiguration(
//           messageTimeIconColor: theme.messageTimeIconColor,
//           messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
//           defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
//             textStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 17.h,
//             ),
//           ),
//           backgroundColor: Colors.white,
//         ),
//         sendMessageConfig: SendMessageConfiguration(
//           imagePickerIconsConfig: ImagePickerIconsConfiguration(
//             cameraIconColor: theme.cameraIconColor,
//             galleryIconColor: theme.galleryIconColor,
//           ),
//           replyMessageColor: Colors.black87,
//           defaultSendButtonColor: Colors.black,
//           // theme.sendButtonColor,
//           replyDialogColor: theme.replyDialogColor,
//           replyTitleColor: theme.replyTitleColor,
//           textFieldBackgroundColor: theme.textFieldBackgroundColor,
//           closeIconColor: theme.closeIconColor,
//           textFieldConfig: TextFieldConfiguration(
//             onMessageTyping: (status) {
//               /// Do with status
//               debugPrint(status.toString());
//             },
//             compositionThresholdTime: const Duration(seconds: 1),
//             textStyle: TextStyle(color: theme.textFieldTextColor),
//           ),
//           // micIconColor: theme.replyMicIconColor,
//           // voiceRecordingConfiguration: VoiceRecordingConfiguration(
//           //   backgroundColor: theme.waveformBackgroundColor,
//           //   recorderIconColor: theme.recordIconColor,
//           //   waveStyle: WaveStyle(
//           //     showMiddleLine: false,
//           //     waveColor: theme.waveColor ?? Colors.white,
//           //     extendWaveform: true,
//           //   ),
//           // ),
//         ),
//         chatBubbleConfig: ChatBubbleConfiguration(
//           outgoingChatBubbleConfig: ChatBubble(
//               linkPreviewConfig: LinkPreviewConfiguration(
//                 backgroundColor: theme.linkPreviewOutgoingChatColor,
//                 bodyStyle: theme.outgoingChatLinkBodyStyle,
//                 titleStyle: theme.outgoingChatLinkTitleStyle,
//               ),
//               receiptsWidgetConfig: const ReceiptsWidgetConfig(
//                   showReceiptsIn: ShowReceiptsIn.all),
//               color: theme.outgoingChatBubbleColor,
//               textStyle: TextStyle(color: Colors.black)),
//           inComingChatBubbleConfig: ChatBubble(
//             linkPreviewConfig: LinkPreviewConfiguration(
//               linkStyle: TextStyle(
//                 color: theme.inComingChatBubbleTextColor,
//                 decoration: TextDecoration.underline,
//               ),
//               backgroundColor: theme.linkPreviewIncomingChatColor,
//               bodyStyle: theme.incomingChatLinkBodyStyle,
//               titleStyle: theme.incomingChatLinkTitleStyle,
//             ),
//             textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
//             onMessageRead: (message) {
//               /// send your message reciepts to the other client
//               debugPrint('Message Read');
//             },
//             senderNameTextStyle:
//                 TextStyle(color: theme.inComingChatBubbleTextColor),
//             color: theme.inComingChatBubbleColor,
//           ),
//         ),
//         replyPopupConfig: ReplyPopupConfiguration(
//           backgroundColor: theme.replyPopupColor,
//           buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
//           topBorderColor: theme.replyPopupTopBorderColor,
//         ),
//         reactionPopupConfig: ReactionPopupConfiguration(
//           shadow: BoxShadow(
//             color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
//             blurRadius: 20,
//           ),
//           backgroundColor: theme.reactionPopupColor,
//         ),
//         messageConfig: MessageConfiguration(
//           customMessageBuilder: (message) {
//             return customOfferMessage(
//                 title: "Cat Travel Gag",
//                 status: "Buyer offers you a price",
//                 imageUrl: "https://i.pravatar.cc/150?img=3",
//                 isSender: true,
//                 price: "\$10",
//                 buttons: [
//                   Expanded(
//                       child: CustomButton(
//                           loaderIgnore: true,
//                           height: 30.h,
//                           boderColor: AppColors.primaryColor,
//                           titlecolor: AppColors.primaryColor,
//                           color: Colors.transparent,
//                           fontSize: 12.h,
//                           title: "Cancel",
//                           onpress: () {})),
//                   SizedBox(width: 8.w),
//                   Expanded(
//                     child: CustomButton(
//                         loaderIgnore: true,
//                         fontSize: 12.h,
//                         height: 30.h,
//                         title: "Purchase",
//                         onpress: () {
//                           Get.toNamed(AppRoutes.confirmPurchaseScreen);
//                         }),
//                   )
//                 ]);
//           },
//           messageReactionConfig: MessageReactionConfiguration(
//             backgroundColor: theme.messageReactionBackGroundColor,
//             borderColor: theme.messageReactionBackGroundColor,
//             reactedUserCountTextStyle:
//                 TextStyle(color: theme.inComingChatBubbleTextColor),
//             reactionCountTextStyle:
//                 TextStyle(color: theme.inComingChatBubbleTextColor),
//             reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
//               backgroundColor: theme.backgroundColor,
//               reactedUserTextStyle: TextStyle(
//                 color: theme.inComingChatBubbleTextColor,
//               ),
//               reactionWidgetDecoration: BoxDecoration(
//                 color: theme.inComingChatBubbleColor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: isDarkTheme ? Colors.black12 : Colors.grey.shade200,
//                     offset: const Offset(0, 20),
//                     blurRadius: 40,
//                   )
//                 ],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           imageMessageConfig: ImageMessageConfiguration(
//             margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//             shareIconConfig: ShareIconConfiguration(
//               defaultIconBackgroundColor: theme.shareIconBackgroundColor,
//               defaultIconColor: theme.shareIconColor,
//             ),
//           ),
//         ),
//         profileCircleConfig: const ProfileCircleConfiguration(
//           profileImageUrl: Data.profileImage,
//         ),
//         repliedMessageConfig: RepliedMessageConfiguration(
//           backgroundColor: theme.repliedMessageColor,
//           verticalBarColor: theme.verticalBarColor,
//           repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
//             enableHighlightRepliedMsg: true,
//             highlightColor: Colors.pinkAccent.shade100,
//             highlightScale: 1.1,
//           ),
//           textStyle: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 0.25,
//           ),
//           replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
//         ),
//         swipeToReplyConfig: SwipeToReplyConfiguration(
//           replyIconColor: theme.swipeToReplyIconColor,
//         ),
//         replySuggestionsConfig: ReplySuggestionsConfig(
//             itemConfig: SuggestionItemConfig(
//               decoration: BoxDecoration(
//                 color: theme.textFieldBackgroundColor,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: theme.outgoingChatBubbleColor ?? Colors.white,
//                 ),
//               ),
//               textStyle: TextStyle(
//                 color: isDarkTheme ? Colors.white : Colors.black,
//               ),
//             ),
//             onTap: (item) {
//               _chatController.addMessage(
//                 Message(
//                   id: DateTime.now().toString(),
//                   createdAt: DateTime.now(),
//                   message: "Buyer offers you a price",
//                   messageType: MessageType.custom,
//                   sentBy: '2',
//                 ),
//               );
//             }
//             // _onSendTap(item.text, const ReplyMessage(), MessageType.text),
//             ),
//       ),
//     );
//   }
//
//   void _onSendTap(
//     String message,
//     ReplyMessage replyMessage,
//     MessageType messageType,
//   ) {
//     final messageObj = Message(
//       id: DateTime.now().toString(),
//       createdAt: DateTime.now(),
//       message: message,
//       sentBy: _chatController.currentUser.id,
//       replyMessage: replyMessage,
//       messageType: MessageType.custom,
//     );
//     _chatController.addMessage(
//       messageObj,
//     );
//
//     Future.delayed(const Duration(milliseconds: 300), () {
//       final index = _chatController.initialMessageList.indexOf(messageObj);
//       _chatController.initialMessageList[index].setStatus =
//           MessageStatus.undelivered;
//     });
//     Future.delayed(const Duration(seconds: 1), () {
//       final index = _chatController.initialMessageList.indexOf(messageObj);
//       _chatController.initialMessageList[index].setStatus = MessageStatus.read;
//     });
//   }
//
//   Widget customOfferMessage({
//     required bool isSender,
//     required String title,
//     required String status,
//     required String price,
//     required String imageUrl,
//     required List<Widget> buttons,
//   }) {
//     return Container(
//       width: 320.w,
//       margin: EdgeInsets.symmetric(vertical: 8.h),
//       padding: EdgeInsets.all(12.r),
//       decoration: BoxDecoration(
//         color: isSender ? const Color(0xFFFFF0DC) : Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.network(
//               imageUrl,
//               width: 48.w,
//               height: 48.h,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(width: 8.h),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomText(
//                     text: title,
//                     color: Colors.black,
//                     fontSize: 16.h,
//                     bottom: 4.h),
//                 CustomText(text: status, bottom: 4.h),
//                 CustomText(text: price, bottom: 10.h),
//                 Row(
//                   children: [...buttons],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class Data {
//   static const String profileImage = "https://i.pravatar.cc/150?img=3";
// }
//
// // Dummy theme system
// late ChatTheme theme = LightTheme();
//
// class ChatTheme {
//   Color appBarColor = Colors.white;
//   Color appBarTitleTextStyle = Colors.black;
//   Color backArrowColor = Colors.black;
//   Color themeIconColor = Colors.black;
//   double elevation = 0;
//   Color textFieldBackgroundColor = Color(0xffFEF3EA);
//   Color outgoingChatBubbleColor = Color(0xffFFD6B0);
//   Color inComingChatBubbleColor = Colors.grey.shade300;
//   Color inComingChatBubbleTextColor = Colors.black;
//   Color messageTimeIconColor = Colors.grey;
//   Color messageTimeTextColor = Colors.black;
//   Color chatHeaderColor = Colors.black;
//   Color cameraIconColor = Colors.black;
//   Color galleryIconColor = Colors.black;
//   Color replyMessageColor = Colors.black;
//   Color sendButtonColor = Colors.blue;
//   Color replyDialogColor = Colors.grey.shade300;
//   Color replyTitleColor = Colors.black;
//   Color closeIconColor = Colors.red;
//   Color textFieldTextColor = Colors.black;
//   Color replyMicIconColor = Colors.purple;
//   Color waveformBackgroundColor = Colors.grey;
//   Color recordIconColor = Colors.red;
//   Color? waveColor = Colors.white;
//   Color linkPreviewOutgoingChatColor = Colors.blue.shade100;
//   TextStyle outgoingChatLinkBodyStyle = const TextStyle();
//   TextStyle outgoingChatLinkTitleStyle = const TextStyle();
//   Color linkPreviewIncomingChatColor = Colors.grey.shade300;
//   TextStyle incomingChatLinkBodyStyle = const TextStyle();
//   TextStyle incomingChatLinkTitleStyle = const TextStyle();
//   Color replyPopupColor = Colors.grey.shade800;
//   Color replyPopupButtonColor = Colors.white;
//   Color replyPopupTopBorderColor = Colors.white;
//   Color reactionPopupColor = Colors.grey.shade300;
//   Color messageReactionBackGroundColor = Colors.blue;
//   Color shareIconBackgroundColor = Colors.black;
//   Color shareIconColor = Colors.white;
//   Color repliedMessageColor = Colors.blue.shade100;
//   Color verticalBarColor = Colors.blue;
//   Color repliedTitleTextColor = Colors.black;
//   Color swipeToReplyIconColor = Colors.grey;
//   Color flashingCircleBrightColor = Colors.blue;
//   Color flashingCircleDarkColor = Colors.blueGrey;
//   Color backgroundColor = Colors.white;
// }
//
// class LightTheme extends ChatTheme {}
//
// class DarkTheme extends ChatTheme {
//   @override
//   Color appBarColor = Colors.black;
//   @override
//   Color appBarTitleTextStyle = Colors.white;
//   @override
//   Color backArrowColor = Colors.white;
//   @override
//   Color themeIconColor = Colors.white;
//   @override
//   Color textFieldBackgroundColor = Colors.grey.shade800;
//   @override
//   Color outgoingChatBubbleColor = Colors.blue.shade900;
//   @override
//   Color inComingChatBubbleColor = Colors.grey.shade700;
//   @override
//   Color inComingChatBubbleTextColor = Colors.white;
//   @override
//   Color chatHeaderColor = Colors.white;
//   @override
//   Color textFieldTextColor = Colors.white;
//   @override
//   Color backgroundColor = Colors.black;
// }

import 'dart:io';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petattix/controller/product_controller.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
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
      appBar: AppBar(
        elevation: 8,
        centerTitle: false,
        title: Row(
          children: [
            Obx(
              () => CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  imageUrl:
                      '${ApiConstants.imageBaseUrl}/${chatController.chatMessages.value.conversation?.image}',
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

                                   productController.sendOffer(id: chatController.chatMessages.value.conversation?.product?.id.toString() ?? "", price: amonCtrl.text);

                                   Get.back();
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
                                              "${ApiConstants.imageBaseUrl}${chatController.chatMessages.value.receiver?.image}",
                                          buttons: [

                                            message?.offer?.status == "accepted" ?
                                            SizedBox(
                                                width: 100.w,
                                                height: 32.h,
                                                child: CustomButton(
                                                  fontSize: 10.h,
                                                  loaderIgnore: true,
                                                  title: "Purchase",
                                                  onpress: () {
                                                    productController.acceptOrCancel(id: message?.offerId.toString() ?? "", status: "accept", buyerId: message?.offer?.buyerId);
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
                                                            productController.acceptOrCancel(id: message?.offerId.toString() ?? "", status: "reject", buyerId: message?.offer?.buyerId);
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
                                                          productController.acceptOrCancel(id: message?.offerId.toString() ?? "", status: "accept", buyerId: message?.offer?.buyerId);
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
                              child: Assets.icons.attachfileIcon.svg(),
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
                CustomText(text: "Offer Price: \$$price", bottom: 10.h, color: Color(0xff27A14B)),
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
