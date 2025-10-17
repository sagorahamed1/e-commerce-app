import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/core/config/app_route.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/helper/time_format_helper.dart';
import 'package:petattix/services/api_constants.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_shimmer_listview.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';
import 'package:petattix/views/widgets/no_data_found_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/product_controller.dart';
import '../../widgets/custom_product_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCtrl = TextEditingController();
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController.getAllProduct();
    productController.fetchCategory();
    super.initState();
  }

  // List accessories = ["Accessories", "Clothing", "Pet beds", "All"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44.h),
            Row(
              children: [
                Assets.images.logo.image(height: 32.h),
                CustomText(
                    text: "PetAttix",
                    fontSize: 32.h,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    left: 8.w),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationScreen);
                    },
                    child: Assets.icons.notification.svg()),
                SizedBox(width: 16.w),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.wishListScreen, arguments: {"title" : "Cart"});
                    },
                    child: Assets.icons.card.svg()),
              ],
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                readOnly: true,
                controller: searchCtrl,
                prefixIcon: Icon(Icons.search),
                hintText: "Search For Pet Product",
                validator: (value) => null,
                onTap: () {
                  Get.toNamed(AppRoutes.allProductScreen, arguments: {"category" : ""})?.then((_){
                    productController.allProduct.clear();
                    productController.getAllProduct();
                  });
                },

              ),
            ),
            // SizedBox(
            //   height: 50.h,
            //   child: ListView.builder(
            //     itemCount: accessories.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Container(
            //           width: 90.w,
            //           margin:
            //               EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(16.r),
            //             border: Border.all(color: Colors.grey, width: 0.05),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Color(0x40000000),
            //                 offset: Offset(0, 0),
            //                 blurRadius: 4,
            //                 spreadRadius: 0,
            //               ),
            //             ],
            //           ),
            //           child: Center(
            //             child: Padding(
            //               padding: EdgeInsets.all(4.r),
            //               child: CustomText(
            //                   text: "${accessories[index]}",
            //                   fontSize: 12.h,
            //                   color: AppColors.primaryColor),
            //             ),
            //           ));
            //     },
            //   ),
            // ),
            CustomText(
                text: "Popular category",
                fontWeight: FontWeight.w500,
                top: 10.h,
                color: Color(0xff592B00)),
            SizedBox(
              height: 100.h,
              child: Obx(
                () => productController.categoryLoading.value
                    ? Row(
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),


                        SizedBox(width: 14.w),

                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),

                        SizedBox(width: 14.w),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ],
                    )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productController.category.length,
                        itemBuilder: (context, index) {
                          var category = productController.category[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.allProductScreen, arguments: {
                                  "category" : category.name.toString()
                                })?.then((_){
                                  productController.allProduct.clear();
                                  productController.getAllProduct();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 55.h,
                                        width: 55.w,
                                        child: CustomNetworkImage(
                                          boxShape: BoxShape.circle,
                                            imageUrl: "${ApiConstants.imageBaseUrl}${category.image}"),
                                      ),
                                      SizedBox(
                                        width: 75.w,
                                        child: CustomText(
                                            text: "${category.name.toString()}",
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff592B00)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Recent product",
                    fontWeight: FontWeight.w500,
                    color: Color(0xff592B00)),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.allProductScreen, arguments: {"category" : ""})?.then((_){
                      productController.allProduct.value = [];
                      productController.getAllProduct();
                    });
                  },
                  child: CustomText(
                      text: "See all...",
                      fontWeight: FontWeight.w500,
                      color: Color(0xff592B00)),
                ),
              ],
            ),
            Expanded(
              child: AnimationLimiter(
                child: Obx(
                  () => productController.allProductLoading.value
                      ? ShimmerListView()
                      : productController.allProduct.isEmpty ? NoDataFoundCard(paddingFromTop: 40.h) : GridView.builder(
                          itemCount: productController.allProduct.length,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.868,
                          ),
                          itemBuilder: (context, index) {
                            var product = productController.allProduct[index];
                            return CustomProductCard(
                              index: index,
                              // isFavorite: false,
                              title: "${product.productName}",
                              address: "${product.addressLine1 ?? "N/A"}",
                              price: "${product.sellingPrice}",
                              image: "${product.images?[0].image}",
                              time: "${TimeFormatHelper.formatDate(product.createdAt ?? DateTime.now())}, ${TimeFormatHelper.timeWithAMPMLocalTime(product.createdAt ?? DateTime.now())}",
                              onTap: () {
                                Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
                                  "index" : product.id
                                })?.then((_){
                                  productController.getAllProduct();
                                });
                              },
                              favoriteOnTap: () {
                                productController.toggleFavourite(id: product.id.toString());
                              },
                            );
                          },
                        ),
                ),
              ),
            ),


            SizedBox(height: 100.h)
          ],
        ),
      ),
    );
  }
}
