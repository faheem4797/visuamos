import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/colors.dart';

class CommonBottomButton extends StatelessWidget {
  final String title;
  final void Function()? bottomButtonCallBackFunc;
  const CommonBottomButton(
      {Key? key, required this.title, required this.bottomButtonCallBackFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      width: 300.w,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
              primary: black,
              textStyle:
                  TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
          onPressed: bottomButtonCallBackFunc,
          child: Text(
            title,
            textAlign: TextAlign.center,
          )),
    );
  }
}
