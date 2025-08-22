import 'package:get/get.dart';
import 'package:petattix/model/favouite_model.dart';

import '../services/api_client.dart';
import '../services/api_constants.dart';

class FavouriteController extends GetxController{


  RxList<FavouiteModel> favouriteProduct = <FavouiteModel>[].obs;
  RxBool favouriteProductLoading = false.obs;

  getFavouriteProduct({String? price}) async {
    favouriteProductLoading(true);
    var response = await ApiClient.getData(
        ApiConstants.favouite("1"));

    print("=============${response.body}");
    if (response.statusCode == 200) {
      favouriteProduct.value = List<FavouiteModel>.from(
          response.body["data"].map((x) => FavouiteModel.fromJson(x)));

      favouriteProductLoading(false);
    } else {
      favouriteProductLoading(false);
    }
  }

}