
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 5,
        shadowColor: Colors.black,
        title: Row(
          children: [
            CustomNetworkImage(
              height: 36.h,
              width: 36.w,
              boxShape: BoxShape.circle,
              imageUrl: "https://randomuser.me/api/portraits/men/10.jpg",
              border: Border.all(color: Colors.grey, width: 0.02),
            ),
            CustomText(text: "Hub Name", fontSize: 20.h, left: 60.w)
          ],
        ),
      ),


      body: Column(
        children: [


          SizedBox(
            height: 100,
            child: Row(
              children: [
                Assets.icons.lock.svg(),

                CustomTextField(controller: TextEditingController(), ),

                Assets.icons.lock.svg(),
              ],
            ),
          )


        ],
      ),
    );
  }
}
