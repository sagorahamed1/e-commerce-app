import 'dart:convert';
import 'package:get/get.dart';

import '../model/chat_user_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';


class ChatListController extends GetxController {
  RxInt page = 1.obs;
  var totalPage = (-1);
  var totalResult = (-1);

  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
      getChatUser();
    }
  }

  @override
  void onInit() {
    chatUsers.clear();
    getChatUser();
    super.onInit();
  }

  RxBool getChatUserLoading = false.obs;
  RxList<ChatUserModel> chatUsers = <ChatUserModel>[].obs;

  getChatUser() async {
    getChatUserLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getChatUser}&page=1");

    if (response.statusCode == 200) {
      totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      totalResult = jsonDecode(response.body['pagination']['total'].toString()) ?? 0;
      // chatUsers.value = List<ChatUserModel>.from(response.body['data']
      //         ['attributes']
      //     .map((x) => ChatUserModel.fromJson(x)));
      var data = List<ChatUserModel>.from(response.body['data'].map((x) => ChatUserModel.fromJson(x)));
      chatUsers.addAll(data);
      getChatUserLoading(false);
    } else if (response.statusCode == 404) {
      getChatUserLoading(false);
    }
  }
}
