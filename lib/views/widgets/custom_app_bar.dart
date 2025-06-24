import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petattix/core/app_constants/app_colors.dart';
import 'package:petattix/views/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Color(0xff592B00)),
      backgroundColor: AppColors.bgColor,
      centerTitle: true,
      title: CustomText(
        text: title ?? "",
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xff592B00),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
