
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/category_model.dart';
import 'custom_text.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<CategoryModel> items;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      //constraints: BoxConstraints(maxHeight: 200.h),
      color: Colors.white,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((CategoryModel item) {
          return PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            height: 24.h,
            value: item.id.toString(),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: const Border(
                      bottom: BorderSide(color: Colors.black, width: 0.7)),
                ),

                child: CustomText(text: item.name.toString(), fontSize: 12.sp)),
          );
        }).toList();
      },
    );
  }
}
