import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/screens/login.dart';

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

  Future openDialog(BuildContext context) {
    String email = '';
    String password = '';
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('For Account Deletion, please re-authenticate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter your email here:'),
              onChanged: (value) {
                email = value;
              },
            ),
            TextField(
              obscureText: true,
              decoration:
                  InputDecoration(hintText: 'Enter your password here:'),
              onChanged: (value) {
                password = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () async {
                User? user = await FirebaseAuth.instance.currentUser;
                if (user != null) {
                  try {
                    UserCredential userReauthenticated =
                        await user.reauthenticateWithCredential(
                      EmailAuthProvider.credential(
                        email: email,
                        password: password,
                      ),
                    );

                    if (userReauthenticated.user?.email == email) {
                      await user.delete();
                      await AuthService().signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false);
                    } else {
                      print('object');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Wrong Credentials'),
                        ),
                      );
                    }
                  } catch (e) {
                    print('object');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Wrong Credentials'),
                      ),
                    );
                  }
                }
              },
              child: Text('Submit'))
        ],
      ),
    );
  }

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
                        //TODO: ADD A DELETE ACCOUNT option here as well
                        ['Logout', 'Delete Account']
                            .map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async {
                      print(newValue);

                      if (newValue == 'Delete Account') {
                        User? user = await FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          openDialog(context);
                        }
                      } else {
                        callBackFunc!();
                      }
                    }),
              )
            : Text('')
      ],
    );
  }
}
