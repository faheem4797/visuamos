import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';

class BalanceSlipWidget extends StatelessWidget {
  final String date;
  final String amount;
  const BalanceSlipWidget({
    super.key,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Group1Widget - GROUP
    return SafeArea(
      child: Scaffold(
        appBar: AppBarEveryWhere(
          title: 'Balance Slips',
          isIconRequired: true,
          callBackFunc: () {
            AuthService().signOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 63.w),
              child: Text(
                'UNIVERSE BANK',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 36.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                'LOCATION: 1733 AVAILABLE ST. ANYTIME, UN 81733',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                'This is not subject to Article 3 of the UCC',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                'Your Wish is My Command',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                'CARD NO: XXXXXXXXXXXX9491',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 42.w),
                  child: Text(
                    'DATE',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 91.w, right: 86.w),
                  child: Text(
                    'TIME',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Text(
                  'TERHINAL',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 62.w, right: 91.w),
                  child: Text(
                    '09:45',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Text(
                  'NFK879T',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 41.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w),
              child: Text(
                'SEQ NO: 6568',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 31.h),
            Padding(
              padding: EdgeInsets.only(left: 247.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AMT:',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 40.w),
                    child: Text(
                      "\$$amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 27.h),
            Padding(
              padding: EdgeInsets.only(left: 145.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ATM OWNER FEE:',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 40.w),
                    child: Text(
                      "\$2",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 27.h),
            Padding(
              padding: EdgeInsets.only(left: 230.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL:',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 40.w),
                    child: Text(
                      "\$${int.parse(amount) - 2}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 46.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 153.w),
              child: Text(
                "THANK YOU",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 58.w),
              child: Text(
                'WELCOME TO UNIVERSE BANK',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 106.w),
              child: Text(
                'UNIVERSEBANK.COM',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
