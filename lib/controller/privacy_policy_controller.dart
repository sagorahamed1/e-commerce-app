import 'dart:convert';

import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import '../services/api_client.dart';

class PrivacyPolicyController extends GetxController{

  RxString valueText = "".obs;
  RxBool privacyPolicyLoading = false.obs;
  final HtmlUnescape unescape = HtmlUnescape();

  getPrivacyPolicyAll({required String url})async{
    privacyPolicyLoading(true);

    var response = await ApiClient.getData("$url");

    if(response.statusCode == 200 || response.statusCode == 201){
      var data = response.body is String ? jsonDecode(response.body) : response.body;
      // valueText.value = data["content"];

      String content = (data["content"] ?? '').toString();

      // Decode HTML entities like &lt;, &amp;, etc.
      String decodedHtml = unescape.convert(content);

      // set the decoded HTML string
      valueText.value = decodedHtml;
      privacyPolicyLoading(false);
    }else{
      privacyPolicyLoading(false);
    }

  }
}