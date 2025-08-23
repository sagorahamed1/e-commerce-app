
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:petattix/services/api_constants.dart';

import '../../global/custom_assets/assets.gen.dart';
import 'cachanetwork_image.dart';
import 'custom_text.dart';

class CustomProductCard extends StatelessWidget {
  final int? index;
  final String? title;
  final String? price;
  final String? address;
  final String? image;
  final DateTime? time;
  final bool? isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? favoriteOnTap;

  const CustomProductCard(
      {super.key,
        this.index,
        this.title,
        this.price,
        this.address,
        this.time,
        this.image,
        this.isFavorite,
        this.onTap, this.favoriteOnTap});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: index ?? 0,
      columnCount: 2,
      duration: Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50,
        child: SlideAnimation(
          delay: Duration(milliseconds: 275),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfffef4ea),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffe3842e),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: CustomNetworkImage(
                              height: 105.h,
                              borderRadius: BorderRadius.circular(10.r),
                              imageUrl:
                              "${ApiConstants.imageBaseUrl}/$image")),
                    ),
                    // Text and icons section
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title

                            Row(
                              children: [
                                Assets.icons.titleIcon.image(),
                                CustomText(
                                    text: " $title",
                                    fontSize: 12.h,
                                    color: Colors.black),
                              ],
                            ),

                            Row(
                              children: [
                                Assets.icons.moneyIconCard.svg(),
                                CustomText(
                                    text: ' $price\$',
                                    fontSize: 12.h,
                                    color: Colors.red),
                              ],
                            ),

                            SizedBox(height: 4.h),

                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: 14.h),
                                SizedBox(
                                  width: 130.w,
                                  child: CustomText(
                                    textAlign: TextAlign.start,
                                      text: "$address",
                                      fontSize: 12.h,
                                      color: Colors.black),
                                ),
                              ],
                            ),


                            Row(
                              children: [
                                Icon(Icons.watch_later_outlined,
                                    size: 14.h),
                                CustomText(
                                    text: "2h ago",
                                    fontSize: 12.h,
                                    color: Colors.black),
                              ],
                            ),

                            // Align(
                            //   alignment: Alignment.bottomRight,
                            //   child: GestureDetector(
                            //     onTap: favoriteOnTap,
                            //     child: Icon(
                            //       isFavorite ?? false
                            //           ? Icons.favorite
                            //           : Icons.favorite_border,
                            //       color: isFavorite ?? false
                            //           ? Colors.red
                            //           : Colors.grey[600],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
