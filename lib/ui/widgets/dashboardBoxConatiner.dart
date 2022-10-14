import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/ui/colors/colors.dart';

class DashboardBoxContainer extends StatelessWidget {
  final String title;

  final Function() onTap;
  const DashboardBoxContainer(
      {Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: BorderRadius.circular(15.r),
        ),
        width: 180.w,
        height: 120.h,
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
