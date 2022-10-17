import 'dart:io';

import 'package:flutter/material.dart';
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
        appBar: AppBarEveryWhere(
          title: 'DashBoard',
          isIconRequired: true,
          callBackFunc: () {
            AuthService().signOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false);
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardBoxContainer(
                  title: 'Balance Slips',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SimpleImage(
                                imageType: 0,
                              )),
                    );
                  },
                ),
                DashboardBoxContainer(
                  title: 'Bank Statements',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SimpleImage(
                                imageType: 1,
                              )),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardBoxContainer(
                  title: 'Dream Checks',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SimpleImage(
                                imageType: 2,
                              )),
                    );
                  },
                ),
                DashboardBoxContainer(
                  title: 'Dream Movies',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DreamMovieScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardBoxContainer(
                  title: 'Vision Boards',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VisionBoardScreen()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
