import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petattix/controller/product_controller.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/helper/currency_get_helper.dart';
import 'package:petattix/helper/time_format_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_app_bar.dart';
import 'package:petattix/views/widgets/custom_button.dart';
import 'package:petattix/views/widgets/custom_shimmer_listview.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';
import 'package:petattix/views/widgets/no_data_found_card.dart';

import '../../widgets/custom_text.dart';

class WishListScreen extends StatefulWidget {
  WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  ProductController productController = Get.put(ProductController());
  final GlobalKey<FormState> forKey = GlobalKey<FormState>();


  @override
  void initState() {
    productController.getMyCard();
    productController.getMyPurches();
    super.initState();
  }

  var title = Get.arguments["title"];
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: "$title"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: ContainedTabBarView(
            initialIndex: data["type"] == "n/a" ? 0 : 1,
            tabBarProperties: TabBarProperties(
              height: 45.h,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              labelStyle:
              TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            ),
            tabs: const [
              Text('                    My Cart                 '),
              Text('           Purchase History          '),
            ],
            views: [
              _buildCartList(),
              _purchaseHistory(id: data["type"]),
            ],
            onChange: (index) {
              if(index == 0){

              }else{
                productController.myPurches.value = [];
                productController.getMyPurches();
              }
            },
          ),
        ));
  }

  Widget _buildCartList() {
    return Obx(() => productController.myCardLoading.value ? ShimmerListView() : productController.myCard.isEmpty ? NoDataFoundCard() :
       Padding(
         padding:  EdgeInsets.only(bottom: 50.h),
         child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
          itemCount: productController.myCard.length,
          itemBuilder: (context, index) {
            var product = productController.myCard[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
              decoration: BoxDecoration(
                color: const Color(0xfffef4ea), // Card background
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 0), // shadow in all directions
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section

                    CustomNetworkImage(
                        borderRadius: BorderRadius.circular(8.r),
                        imageUrl: product.images?.isEmpty ?? false ? "" :
                        "${ApiConstants.imageBaseUrl}/${product.images?.first["image"]}",
                        height: 139.h,
                        width: 109.w),

                    SizedBox(width: 7.w),

                    // Info Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  textAlign: TextAlign.start,
                                    text: "${product.productName}",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),

                              // Spacer(),

                              Icon(Icons.favorite, color: Colors.red)
                            ],
                          ),


                          Row(
                            children: [
                              Assets.icons.moneyIconCard.svg(),
                              SizedBox(width: 4.w),
                              CustomText(
                                text: "${CurrencyHelper.getCurrencyPrice(product.sellingPrice.toString())}",
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          CustomText(
                              text: "Pet Type: ${product.category}",
                              fontSize: 12.h,
                              bottom: 4.h,
                              color: Colors.black),
                          CustomText(
                            text: "Condition: ${product.condition}",
                            fontSize: 12.h,
                            bottom: 4.h,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: "Size: ${product.size}",
                            fontSize: 12.h,
                            color: Colors.black,
                            bottom: 7.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                    height: 26.h,
                                    title: "Offer Price",
                                    onpress: () {
                                      TextEditingController amonCtrl = TextEditingController();
                                      amonCtrl.text = product.sellingPrice.toString();

                                      final double sellingPrice = double.tryParse(product.sellingPrice.toString(),
                                      ) ??
                                          0.0;

                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Form(
                                              key: forKey,
                                              child: Column(
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
                                                      validator: (value) {
                                                        if (value == null || value.trim().isEmpty) {
                                                          return "Please enter a price.";
                                                        }

                                                        final entered = double.tryParse(value) ?? 0.0;

                                                        if (entered <= 0) {
                                                          return "Please enter a valid amount.";
                                                        }

                                                        if (entered > sellingPrice) {
                                                          return "Offer cannot be higher than \n the selling price (${CurrencyHelper.getCurrencyPrice(sellingPrice.toString())})";
                                                        }

                                                        return null; // ✅ valid
                                                      },
                                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                                                            loading: false,
                                                            loaderIgnore: true,
                                                            height: 50.h,
                                                            title: "Offer",
                                                            onpress: () {
                                                              // Get.toNamed(AppRoutes
                                                              //     .messageScreen);

                                                              if(forKey.currentState!.validate()){
                                                                productController.sendOffer(
                                                                    id: product.id.toString(),
                                                                    price: amonCtrl.text, context:  context);
                                                              }


                                                            },
                                                            fontSize: 11.h),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    color: Colors.transparent,
                                    fontSize: 11.h,
                                    loaderIgnore: true,
                                    boderColor: AppColors.primaryColor,
                                    titlecolor: AppColors.primaryColor),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                    loading: false,
                                    loaderIgnore: true,
                                    height: 26.h,
                                    title:  product.status == "in_progress"?"Courier":"Purchase",
                                    onpress: () {
                                   product.status == "in_progress"?
                                   Get.toNamed(AppRoutes.courierScreen, arguments: {
                                     "productId" : "${product.id}"
                                   })
                                       :   Get.toNamed(AppRoutes.confirmPurchaseScreen, arguments: {
                                        "productId" : product.id
                                      });
                                    },
                                    fontSize: 11.h),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
               ),
       ),
    );
  }


  int ratingX = 5;

  Widget _purchaseHistory({String? id}) {
    return Obx( () => productController.purchesLoading.value ? ShimmerListView() : productController.myPurches.isEmpty ? NoDataFoundCard() :
       ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
        itemCount: productController.myPurches.length,
        itemBuilder: (context, index) {
          var purches = productController.myPurches[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
            decoration: BoxDecoration(
              border: Border.all(color: id == purches.id.toString() ?  AppColors.primaryColor : Colors.transparent),
              color: const Color(0xfffef4ea), // Card background
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 0), // shadow in all directions
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section

                  CustomNetworkImage(
                      borderRadius: BorderRadius.circular(8.r),
                      imageUrl: purches.product?.images?.isEmpty ?? false ? "" :
                      "${ApiConstants.imageBaseUrl}/${purches.product?.images?.first.image}",
                      height: 139.h,
                      width: 109.w),

                  SizedBox(width: 7.w),

                  // Info Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                  text: "${purches.product?.productName}",
                                  fontWeight: FontWeight.w600,
                                  bottom: 4.h,
                                  color: Colors.black),
                            ),

                          ],
                        ),


                        Row(
                          children: [
                            Assets.icons.moneyIconCard.svg(),
                            SizedBox(width: 4.w),
                            CustomText(
                              text: "${CurrencyHelper.getCurrencyPrice(purches.product?.sellingPrice.toString() ?? "0")}",
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ],
                        ),


                        CustomText(
                          text: "Category: ${purches.product?.category}",
                          fontSize: 12.h,
                          color: Colors.black,
                          bottom: 7.h,
                        ),

                        CustomText(
                          text: "Date of purchase: ${TimeFormatHelper.formatDate(purches.createdAt ?? DateTime.now())}",
                          fontSize: 12.h,
                          bottom: 4.h,
                          color: Colors.black,
                        ),

                        Row(
                          children: [
                            CustomText(text: "Status", color: Colors.black),
                            Spacer(),


                            Container(
                              decoration: BoxDecoration(
                                color: purches.status
                                    .toString()
                                    .toLowerCase() == "prepeared" ? Color(0xffCCE7FF) :
                                purches.status
                                    .toString()
                                    .toLowerCase() == "delivery_filled" ? Color(0xffD1F5D3) :
                                Color(0xffFFF4CC),
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: Offset(
                                        0, 0), // shadow in all directions
                                  ),
                                ],
                              ),

                              child: CustomText(
                                text: "${purches.status?.replaceAll("_", " ").toLowerCase().capitalizeFirst}",
                                left: 8.w,
                                right: 8.w,),
                            ),
                          ],
                        ),


                        SizedBox(height: 12.h),


                        purches.status.toString().toLowerCase() == "prepeared" ?
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {



                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                            text: "Completed",
                                            fontSize: 16.h,
                                            fontWeight: FontWeight.w600,
                                            top: 29.h,
                                            bottom: 20.h,
                                            color: Color(0xff592B00)),
                                        Divider(),


                                        CustomText(top: 7.h,bottom: 6.h, text: "Do you want to completed", color: Colors.black),



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
                                                  title: "Completed",
                                                  onpress: () {

                                                    productController.changeStatus(
                                                        status: "delivered",
                                                        oderId: purches.id.toString(), context: context);
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
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                child: CustomText(text: "I’ve Received the Product", color: Colors.white, fontSize: 12.h),
                              ),
                            ),
                          ),
                        )
                            :
                        purches.status.toString().toLowerCase() == "delivered"  ?

                        Row(
                          children: [
                            // Expanded(
                            //   flex: 1,
                            //   child: CustomButton(
                            //       height: 26.h,
                            //       title: "Request Refund",
                            //       onpress: () {
                            //         Get.toNamed(AppRoutes.refundRequestScreen);
                            //       },
                            //       color: Colors.transparent,
                            //       fontSize: 9.h,
                            //       loaderIgnore: true,
                            //       boderColor: AppColors.primaryColor,
                            //       titlecolor: AppColors.primaryColor),
                            // ),
                            SizedBox(width: 8.w),
                            Expanded(
                              flex: 1,
                              child: CustomButton(
                                  loading: false,
                                  loaderIgnore: true,
                                  height: 26.h,
                                  title: "Rate Seller",
                                  onpress: () {



                                    TextEditingController reviewMeg =
                                    TextEditingController();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomText(
                                                  text: "Rate Your Experience",
                                                  fontSize: 16.h,
                                                  fontWeight: FontWeight.w600,
                                                  top: 29.h,
                                                  bottom: 20.h,
                                                  color: Color(0xff592B00)),
                                              Divider(),


                                              CustomText(top: 7.h,bottom: 6.h, text: "Product Summary Card", color: Colors.black),



                                              Row(
                                                children: [
                                                  CustomNetworkImage(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      imageUrl:
                                                      "${ApiConstants.imageBaseUrl}/${purches.product?.images?[0].image}",
                                                      height: 71.h,
                                                      width: 61.w),

                                                  SizedBox(width: 12.w),

                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      CustomText(text: "${purches.product?.productName}", color: Colors.black),
                                                      CustomText(text: "Category: ${purches.product?.category}", color: Colors.black, fontSize: 12.h),
                                                      CustomText(text: "Brand: ${purches.product?.brand}", color: Colors.black, fontSize: 12.h),

                                                    ],
                                                  )
                                                ],
                                              ),

                                              SizedBox(height: 12.h),

                                              Align(
                                                alignment: Alignment.center,
                                                child: RatingBar.builder(
                                                  initialRating: 5,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemSize: 22,
                                                  itemCount: 5,
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {


                                                    setState(() {
                                                      ratingX = rating.toInt();
                                                    });
                                                    print(rating);
                                                  },
                                                ),
                                              ),

                                              SizedBox(height: 12.h),
                                              CustomTextField(
                                                  controller: reviewMeg,
                                                  hintText: "Review"),


                                              CustomText(fontSize: 12.h,text: " Please Leave A Review For this service.", color: AppColors.primaryColor, bottom: 18.h),


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
                                                        title: "Submit",
                                                        onpress: () {

                                                          productController.review(
                                                            reviewMessage: reviewMeg.text,
                                                            rating: ratingX.toInt(),
                                                              userId: purches.sellerId.toString(), context: context);


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
                                  fontSize: 9.h),
                            ),
                          ],
                        ) : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
