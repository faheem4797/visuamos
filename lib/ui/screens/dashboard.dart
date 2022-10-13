import 'package:flutter/material.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';

import '../widgets/dashboardBoxConatiner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
              children: const [
                DashboardBoxContainer(title: 'Balance Slips'),
                DashboardBoxContainer(title: 'Bank Statements'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                DashboardBoxContainer(title: 'Dream Checks'),
                DashboardBoxContainer(title: 'Dream Movies'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                DashboardBoxContainer(title: 'Vision Boards'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
