import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/toast_message_helper.dart';
import '../model/category_model.dart';
import '../model/country_model.dart';
import '../model/product_model.dart';
import '../model/single_product_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class ProductController extends GetxController {
  RxBool productAddLoading = false.obs;

  addProduct(
      {required String productName,
      category,
      quantity,
      brand,
      condition,
      phurcasingPrice,
      sellingPrice,
      description,
      size,
      height,
      width,
      length,
      weight,
      city,
      postalCode,
      countryCode,
      countryId,
      addressLine1,
      addressLine2,
      country,
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
      "category": "$category",
      "quantity": "$quantity",
      "description": "$description",
      "condition": "$condition",
      "brand": "$brand",
      "is_negotiable": "$negotiable",
      "size": "$size",
      "height": "$height",
      "width": "$width",
      "length": "$length",
      "weight": "$weight",
      "city": "$city",
      "postal_code": "$postalCode",
      "country_id": "$countryId",
      "country_code": "$countryCode",
      "address_line_1": "$addressLine1",
      "address_line_2": "$addressLine2",
      "is_address_residential": "true",
      "country": "$country"
    };

    final response = await ApiClient.postMultipartData(
        ApiConstants.product, body,
        multipartBody: photoList);

    print(
        "========================================================================= ${response.body}");

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
    var response = await ApiClient.getData(
        "${ApiConstants.product}?page=1&limit=10&type=own");

    print("=============${response.body}");
    if (response.statusCode == 200) {
      myProduct.value = List<ProductModel>.from(
          response.body["data"].map((x) => ProductModel.fromJson(x)));

      myProductLoading(false);
    } else {
      myProductLoading(false);
    }
  }

  RxList<ProductModel> allProduct = <ProductModel>[].obs;
  RxBool allProductLoading = false.obs;

  getAllProduct({String? price}) async {
    allProductLoading(true);
    var response = await ApiClient.getData(
        "${ApiConstants.product}?page=1&limit=10&type=global&price=${price ?? ""}");

    print("=============${response.body}");
    if (response.statusCode == 200) {
      allProduct.value = List<ProductModel>.from(
          response.body["data"].map((x) => ProductModel.fromJson(x)));

      allProductLoading(false);
    } else {
      allProductLoading(false);
    }
  }

  Rx<SingleProductModel> singleProduct = SingleProductModel().obs;
  RxBool singleProductLoading = false.obs;

  getSingleProduct({String? id}) async {
    allProductLoading(true);
    var response =
        await ApiClient.getData("${ApiConstants.product}/${id ?? ""}");

    print("=============${response.body}");
    if (response.statusCode == 200) {
      singleProduct.value = SingleProductModel.fromJson(response.body["data"]);

      allProductLoading(false);
    } else {
      allProductLoading(false);
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
    } else {
      categoryLoading(false);
    }
  }



  RxBool toggleFavouriteLoading = false.obs;

  toggleFavourite({required String id}) async {
    toggleFavouriteLoading(true);

    var body = {"productId": int.parse(id)};

    var response =
        await ApiClient.postData(ApiConstants.favourites, jsonEncode(body));

    if (response.statusCode == 200) {
      toggleFavouriteLoading(false);
    } else {
      toggleFavouriteLoading(false);
    }
  }




  RxBool sendOfferLoading = false.obs;

  sendOffer({required String id, price}) async {
    sendOfferLoading(true);

    var body = {
      "product_id" : int.parse(id),
      "price": double.parse(price)};

    var response =
    await ApiClient.postData(ApiConstants.offerSend, jsonEncode(body));

    if (response.statusCode == 200) {
      sendOfferLoading(false);
    } else {
      sendOfferLoading(false);
    }
  }




  RxBool acceptOrCancelLoading = false.obs;

  acceptOrCancel({required String id, buyerId, status}) async {
    acceptOrCancelLoading(true);

    var body = {
      "buyer_id" : buyerId
    };

    var response =
    await ApiClient.postData("${ApiConstants.offerAccept}/${id??""}/${status??""}", jsonEncode(body));

    if (response.statusCode == 200) {
      acceptOrCancelLoading(false);
    } else {
      acceptOrCancelLoading(false);
    }
  }




  RxBool deleteMyProductLoading = false.obs;

  deleteMyProduct({required BuildContext context, required String id}) async {
    deleteMyProductLoading(true);

    var response = await ApiClient.deleteData("${ApiConstants.product}/${id}",
        body: jsonEncode({}));

    if (response.statusCode == 204 || response.statusCode == 200) {
      myProduct.removeWhere((element) => element.id == id);
      update();
      myProduct.refresh();
      ToastMessageHelper.showToastMessage(context, "Product deleted!");
      deleteMyProductLoading(false);
    } else {
      deleteMyProductLoading(false);
    }
  }





  var isLoading = false.obs;
  RxList<CountryModel> country = <CountryModel>[].obs;
  RxList<CountryModel> filteredCountry = <CountryModel>[].obs;
  RxBool isListVisible = false.obs; // list open/close toggle

  Future<void> fetchCountries() async {
    var body = {
      "Credentials": {"APIKey": "5XW2Mnqfz6", "Password": "oWMmGi2[8n"}
    };

    isLoading.value = true;

    final response = await ApiClient.dummyPostData(
      "https://services3.transglobalexpress.co.uk/Country/V2/GetCountries",
      jsonEncode(body),
    );

    if (response.statusCode == 200) {
      country.value = List<CountryModel>.from(
        response.body["Countries"].map(
          (x) => CountryModel(
            countryId: x["CountryID"],
            title: x["Title"],
            countryCode: x["CountryCode"],
          ),
        ),
      );

      filteredCountry.value = country; // initially all
    }

    isLoading.value = false;
  }

  /// Search Function
  void searchCountry(String query) {
    if (query.isEmpty) {
      filteredCountry.value = country;
    } else {
      filteredCountry.value = country
          .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }




}
