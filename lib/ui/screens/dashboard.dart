import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/screens/dreamMovieScreen.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/screens/simple_image.dart';
import 'package:visuamos/ui/screens/visionBoardScreen.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';

import '../widgets/dashboardBoxConatiner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Future<void> abc() async {
  //   if (Platform.isAndroid) {
  //     await requestPermission(Permission.storage);
  //   } else {
  //     await requestPermission(Permission.photos);
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [lightBlueGradient, purpleGradient])),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w, top: 10.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: DropdownButton(
                          underline: Container(),
                          icon: Icon(
                            Icons.account_circle,
                            size: 42.sp,
                            color: black,
                          ),
                          items: ['Logout', 'Delete Account']
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          onChanged: (String? newValue) async {
                            print(newValue);

                            if (newValue == 'Delete Account') {
                              User? user =
                                  await FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                openDialog(context);
                              }
                            } else {
                              await AuthService().signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                  (Route<dynamic> route) => false);
                            }
                          }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h, right: 15.w),
                      child: Image.asset(
                        'assets/dashboardImage.png',
                        fit: BoxFit.fitHeight,
                        height: 130,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 70.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Make Your Dreams Come True',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: black,
                              fontSize: 34.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: Text(
                            'The App will give you the\ndream movies, balance slips,\nbank statements, dream check\ntools to help you visualize\nyour dreams true.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: black,
                              fontSize: 18.sp,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //TODO: Add a popup dialog for every button with 3/4 options
                    DashboardButton(
                      'Balance Slips',
                      'assets/dashboard/balance_slip.png',
                      dashboardButton1GradientFirst,
                      dashboardButton1GradientSecond,
                      true,
                    ),
                    DashboardButton(
                      'Bank Statements',
                      'assets/dashboard/bank_statement.png',
                      dashboardButton2GradientFirst,
                      dashboardButton2GradientSecond,
                      false,
                    ),
                    DashboardButton(
                      'Dream Checks',
                      'assets/dashboard/dream_check.png',
                      dashboardButton3GradientFirst,
                      dashboardButton3GradientSecond,
                      false,
                    ),
                    DashboardButton(
                      'Dream Movies',
                      'assets/dashboard/dream_movie.png',
                      dashboardButton4GradientFirst,
                      dashboardButton4GradientSecond,
                      false,
                    ),
                    DashboardButton(
                      'Vision Boards',
                      'assets/dashboard/vision_board.png',
                      dashboardButton5GradientFirst,
                      dashboardButton5GradientSecond,
                      true,
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Container DashboardButton(String title, String imagePath, Color firstColor,
      Color secondColor, bool alignUpDown) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: alignUpDown ? Alignment.topCenter : Alignment.bottomLeft,
            end: alignUpDown ? Alignment.bottomCenter : Alignment.topRight,
            colors: [firstColor, secondColor]),
        borderRadius: BorderRadius.circular(25.r),
      ),
      height: 70.h,
      width: 265.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
        onPressed: () async {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagePath,
              // width: 40.w,
              // fit: BoxFit.fitWidth,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

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
}
