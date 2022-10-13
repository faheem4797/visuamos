import 'package:flutter/material.dart';

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
      height: 85,
      width: 300,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              primary: black,
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          onPressed: bottomButtonCallBackFunc,
          child: Text(title)),
    );
  }
}
