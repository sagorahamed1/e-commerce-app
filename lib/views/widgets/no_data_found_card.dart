import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petattix/global/custom_assets/assets.gen.dart';

class NoDataFoundCard extends StatelessWidget {
  final double? paddingFromTop;
  const NoDataFoundCard({super.key, this.paddingFromTop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        children: [
          SizedBox(height: paddingFromTop ?? 150.h),
          Assets.images.noDataFound.image(),
        ],
      ),
    );
  }
}
