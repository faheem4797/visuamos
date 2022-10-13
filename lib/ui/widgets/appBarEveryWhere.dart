import 'package:flutter/material.dart';

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
      backgroundColor: darkBlue,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 26, fontWeight: FontWeight.bold, color: black),
      ),
      actions: [
        isIconRequired
            ? Padding(
                padding: const EdgeInsets.only(top: 5, right: 10),
                child: DropdownButton(
                    underline: Container(),
                    icon: const Icon(
                      Icons.account_circle,
                      size: 42,
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
