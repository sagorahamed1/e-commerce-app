import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';

class NoDataFoundCard extends StatelessWidget {
  const NoDataFoundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        children: [
          SizedBox(height: 150.h),
          Assets.images.noDataFound.image(),
        ],
      ),
    );
  }
}
