import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:petattix/model/category_model.dart';
import 'package:petattix/model/product_model.dart';

import '../services/api_client.dart';
import '../services/api_constants.dart';

class ProductController extends GetxController {
  RxBool productAddLoading = false.obs;

  addProduct(
      {required String productName,
      category,
      quantity,
      brand,
      location,
      condition,
      phurcasingPrice,
      sellingPrice,
      description,
      required bool negotiable,
      required List<File> images}) async {
    productAddLoading(true);

    List<MultipartBody> photoList = [];

    for (var photos in images) {
      photoList.add(MultipartBody("images", photos));
    }

    var body = {
      "product_name": "$productName",
      "selling_price": "$sellingPrice",
      "phurcasing_price": "$phurcasingPrice",
      // "category_id": "$",
      "category": "$category",
      "quantity": "$quantity",
      "description": "$description",
      "condition": "$condition",
      "brand": "$brand",
      "is_negotiable": "$negotiable",
      "address": "$location",
      "size": "xl",
    };

    final response = await ApiClient.postMultipartData(
        ApiConstants.product, body,
        multipartBody: photoList);

    if (response.statusCode == 200 || response.statusCode == 201) {
      productAddLoading(false);
    } else {
      productAddLoading(false);
    }
  }



  RxList<ProductModel> myProduct = <ProductModel>[].obs;
  RxBool myProductLoading = false.obs;

  getMyProduct() async {
    myProductLoading(true);
    var response = await ApiClient.getData("${ApiConstants.product}?page=1&limit=10&type=own");

    print("=============${response.body}");
    if (response.statusCode == 200) {

      myProduct.value = List<ProductModel>.from(response.body["data"].map((x)=> ProductModel.fromJson(x)));

      myProductLoading(false);
    }else{
      myProductLoading(false);
    }
  }



  RxList<CategoryModel> category = <CategoryModel>[].obs;
  RxBool categoryLoading = false.obs;

  fetchCategory() async {
    categoryLoading(true);
    var response = await ApiClient.getData(ApiConstants.getCategory);

    if (response.statusCode == 200) {
      category.value = List<CategoryModel>.from(
          response.body["data"].map((x) => CategoryModel.fromJson(x)));

      categoryLoading(false);
    }else{
      categoryLoading(false);
    }
  }
}
