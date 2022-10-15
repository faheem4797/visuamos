import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/colors.dart';

class AppBarEveryWhere extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  final String title;
  final bool isIconRequired;
  final Function? callBackFunc;
  const AppBarEveryWhere({
    super.key,
    required this.title,
    required this.isIconRequired,
    this.callBackFunc,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: black),
      backgroundColor: darkBlue,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24.sp, fontWeight: FontWeight.bold, color: black),
      ),
      actions: [
        isIconRequired
            ? Padding(
                padding: EdgeInsets.only(top: 5.h, right: 10.w),
                child: DropdownButton(
                    underline: Container(),
                    icon: Icon(
                      Icons.account_circle,
                      size: 42.sp,
                      color: black,
                    ),
                    items:
                        ['Logout'].map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      callBackFunc!();
                      //
                      //
                      //
                      //
                      //LOGOUT THE USER
                      //
                      //
                      //
                    }),
              )
            : Text('')
      ],
    );
  }
}
