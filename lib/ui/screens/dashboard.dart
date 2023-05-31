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
                child: Text('fdfdf'),
              ),
            )
          ],
        )),
        // Column(

        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         DashboardBoxContainer(
        //           title: 'Balance Slips',
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const SimpleImage(
        //                         imageType: 0,
        //                       )),
        //             );
        //           },
        //         ),
        //         DashboardBoxContainer(
        //           title: 'Bank Statements',
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const SimpleImage(
        //                         imageType: 1,
        //                       )),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         DashboardBoxContainer(
        //           title: 'Dream Checks',
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const SimpleImage(
        //                         imageType: 2,
        //                       )),
        //             );
        //           },
        //         ),
        //         DashboardBoxContainer(
        //           title: 'Dream Movies',
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const DreamMovieScreen()),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         DashboardBoxContainer(
        //           title: 'Vision Boards',
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const VisionBoardScreen()),
        //             );
        //           },
        //         ),
        //       ],
        //     )
        //   ],
        // ),
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
