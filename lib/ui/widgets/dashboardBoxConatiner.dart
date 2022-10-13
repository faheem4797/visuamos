import 'package:flutter/material.dart';
import 'package:visuamos/ui/colors/colors.dart';

class DashboardBoxContainer extends StatelessWidget {
  final String title;
  const DashboardBoxContainer({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 180,
      height: 120,
      child: Center(
          child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
    );
  }
}
