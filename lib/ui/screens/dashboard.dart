import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/screens/dreamMovieScreen.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/screens/sampleSimpleImage.dart';
import 'package:visuamos/ui/screens/sample_dream_movie.dart';
import 'package:visuamos/ui/screens/sample_vision_board.dart';
import 'package:visuamos/ui/screens/simple_image.dart';
import 'package:visuamos/ui/screens/visionBoardScreen.dart';

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
                    DashboardButton(
                      'Balance Slips',
                      'assets/dashboard/balance_slip.png',
                      dashboardButton1GradientFirst,
                      dashboardButton1GradientSecond,
                      true,
                      () {
                        showCustomDialog(context, 'Balance Slips');
                      },
                    ),
                    DashboardButton(
                      'Bank Statements',
                      'assets/dashboard/bank_statement.png',
                      dashboardButton2GradientFirst,
                      dashboardButton2GradientSecond,
                      false,
                      () {
                        showCustomDialog(context, 'Bank Statements');
                      },
                    ),
                    DashboardButton(
                      'Dream Checks',
                      'assets/dashboard/dream_check.png',
                      dashboardButton3GradientFirst,
                      dashboardButton3GradientSecond,
                      false,
                      () {
                        showCustomDialog(context, 'Dream Checks');
                      },
                    ),
                    DashboardButton(
                      'Dream Movies',
                      'assets/dashboard/dream_movie.png',
                      dashboardButton4GradientFirst,
                      dashboardButton4GradientSecond,
                      false,
                      () {
                        showCustomDialog(context, 'Dream Movies');
                      },
                    ),
                    DashboardButton(
                      'Vision Boards',
                      'assets/dashboard/vision_board.png',
                      dashboardButton5GradientFirst,
                      dashboardButton5GradientSecond,
                      true,
                      () {
                        showCustomDialog(context, 'Vision Boards');
                      },
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

  showCustomDialog(BuildContext context, String title) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 50.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 270.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          backgroundColor: bluePopupButton,
                          textStyle: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        child: Text(title == 'Balance Slips'
                            ? 'Add a Balance Slip'
                            : title == 'Bank Statements'
                                ? 'Add a Bank Statement'
                                : title == 'Dream Checks'
                                    ? 'Add a Dream Check'
                                    : title == 'Dream Movies'
                                        ? 'Add a Dream Movie'
                                        : 'Add a Vision Board'),
                      ),

                      //TODO: Have to create new pages for this to accomodate the changes

                      onPressed: () => title == 'Balance Slips'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SimpleImage(
                                  imageType: 0,
                                ),
                              ),
                            )
                          : title == 'Bank Statements'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SimpleImage(
                                      imageType: 1,
                                    ),
                                  ),
                                )
                              : title == 'Dream Checks'
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SimpleImage(
                                          imageType: 2,
                                        ),
                                      ),
                                    )
                                  : title == 'Dream Movies'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DreamMovieScreen(),
                                          ),
                                        )
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VisionBoardScreen(),
                                          ),
                                        ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 270.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          backgroundColor: purplePopupButton,
                          textStyle: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        child: Text(title == 'Balance Slips'
                            ? 'View Balance Slip'
                            : title == 'Bank Statements'
                                ? 'View Bank Statement'
                                : title == 'Dream Checks'
                                    ? 'View Dream Check'
                                    : title == 'Dream Movies'
                                        ? 'View Dream Movie'
                                        : 'View Vision Board'),
                      ),
                      onPressed: () => title == 'Balance Slips'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SimpleImage(
                                  imageType: 0,
                                ),
                              ),
                            )
                          : title == 'Bank Statements'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SimpleImage(
                                      imageType: 1,
                                    ),
                                  ),
                                )
                              : title == 'Dream Checks'
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SimpleImage(
                                          imageType: 2,
                                        ),
                                      ),
                                    )
                                  : title == 'Dream Movies'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DreamMovieScreen(),
                                          ),
                                        )
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VisionBoardScreen(),
                                          ),
                                        ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 270.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          backgroundColor: bluePopupButton,
                          textStyle: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        child: Text(title == 'Balance Slips'
                            ? 'Sample Balance Slip'
                            : title == 'Bank Statements'
                                ? 'Sample Bank Statement'
                                : title == 'Dream Checks'
                                    ? 'Sample Dream Check'
                                    : title == 'Dream Movies'
                                        ? 'Sample Dream Movie'
                                        : 'Sample Vision Board'),
                      ),
                      onPressed: () => title == 'Balance Slips'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SampleSimpleImage(
                                  imageType: 0,
                                ),
                              ),
                            )
                          : title == 'Bank Statements'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SampleSimpleImage(
                                      imageType: 1,
                                    ),
                                  ),
                                )
                              : title == 'Dream Checks'
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SampleSimpleImage(
                                          imageType: 2,
                                        ),
                                      ),
                                    )
                                  : title == 'Dream Movies'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SampleDreamMovie(),
                                          ),
                                        )
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SampleVisionBoard(),
                                          ),
                                        ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Container DashboardButton(String title, String imagePath, Color firstColor,
      Color secondColor, bool alignUpDown, final Function() callBackFunc) {
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
        onPressed: callBackFunc,
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
