import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';
import 'package:petattix/views/widgets/cachanetwork_image.dart';
import 'package:petattix/views/widgets/custom_text.dart';
import 'package:petattix/views/widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCtrl = TextEditingController();

  List accessories = ["Accessories", "Clothing", "Pet beds", "All"];

  List categoryList = [
    {
      "title": "Cat",
      "image":
          Assets.images.cat.image(fit: BoxFit.cover, height: 50.h, width: 50.w)
    },
    {
      "title": "Dog",
      "image":
          Assets.images.dog.image(fit: BoxFit.cover, height: 50.h, width: 50.w)
    },
    {
      "title": "Bird",
      "image":
          Assets.images.bird.image(fit: BoxFit.cover, height: 50.h, width: 50.w)
    },
    {
      "title": "All",
      "image": Assets.images.allCategory
          .image(fit: BoxFit.cover, height: 50.h, width: 50.w)
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    text: "PetAtix",
                    fontSize: 32.h,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    left: 8.w),
                Spacer(),
                Assets.icons.notification.svg(),
                SizedBox(width: 16.w),
                Assets.icons.card.svg(),
              ],
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                controller: searchCtrl,
                prefixIcon: Icon(Icons.search),
                hintText: "Search For Pet Product",
              ),
            ),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                itemCount: accessories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                      width: 90.w,
                      margin:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey, width: 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(4.r),
                          child: CustomText(
                              text: "${accessories[index]}",
                              fontSize: 12.h,
                              color: AppColors.primaryColor),
                        ),
                      ));
                },
              ),
            ),
            CustomText(
                text: "Popular category",
                fontWeight: FontWeight.w500,
                top: 10.h,
                color: Color(0xff592B00)),
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.2), width: 1),
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
                              height: 50.h,
                              width: 50.w,
                              child: categoryList[index]["image"],
                            ),
                            CustomText(
                                text: categoryList[index]["title"],
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff592B00)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Recent category",
                    fontWeight: FontWeight.w500,
                    color: Color(0xff592B00)),
                CustomText(
                    text: "See all...",
                    fontWeight: FontWeight.w500,
                    color: Color(0xff592B00)),
              ],
            ),
            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  itemCount: 50,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.868,
                  ),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 2,
                      duration: Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: SlideAnimation(
                          delay: Duration(milliseconds: 275),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xfff2e6cc),
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
                                          padding:  EdgeInsets.all(8.r),
                                          child: CustomNetworkImage(
                                            height: 105.h,
                                              borderRadius: BorderRadius.circular(10.r),
                                              imageUrl: "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773")),
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
                                                CustomText(text: " Cat Travel Bag", fontSize: 12.h, color: Colors.black),
                                              ],
                                            ),



                                            Row(
                                              children: [
                                                Assets.icons.moneyIconCard.svg(),

                                                CustomText(text: ' 30\$', fontSize: 12.h, color: Colors.red),
                                              ],
                                            ),

                                            SizedBox(height: 4.h),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on_outlined, size: 14.h),
                                                    CustomText(text: "Banasree", fontSize: 12.h, color: Colors.black),
                                                  ],
                                                ),


                                                Row(
                                                  children: [
                                                    Icon(Icons.watch_later_outlined, size: 14.h),
                                                    CustomText(text: "2h ago", fontSize: 12.h, color: Colors.black),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Icon(
                                                Icons.favorite_border,
                                                color: Colors.grey[600],
                                              ),
                                            ),
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
