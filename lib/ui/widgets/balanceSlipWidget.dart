import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/screens/login.dart';
import 'package:visuamos/ui/utils.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 44.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 63.w),
          child: Text(
            'UNIVERSE BANK',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 36.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(height: 35.h),
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Text(
            'LOCATION: 1733 AVAILABLE ST. ANYTIME, UN 81733',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(height: 13.h),
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Text(
            'This is not subject to Article 3 of the UCC',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Text(
            'Your Wish is My Command',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Text(
            'CARD NO: XXXXXXXXXXXX9491',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 44.w),
              child: Text(
                'DATE',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 88.w, right: 83.w),
              child: Text(
                'TIME',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
            ),
            Text(
              'TERHINAL',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                fontFamily: 'Merriweather',
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 26.w),
              child: Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 59.w, right: 88.w),
              child: Text(
                '09:45',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
            ),
            Text(
              'NFK879T',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                fontFamily: 'Merriweather',
              ),
            ),
          ],
        ),
        SizedBox(height: 67.h),
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Text(
            'SEQ NO: 6568',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(height: 36.h),
        Padding(
          padding: EdgeInsets.only(left: 250.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AMT:',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 37.w),
                child: Text(
                  "\$$amount",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 51.h),
        Padding(
          padding: EdgeInsets.only(left: 147.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ATM OWNER FEE:',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 37.w),
                child: Text(
                  "\$2",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 51.h),
        Padding(
          padding: EdgeInsets.only(left: 232.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL:',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 37.w),
                child: Text(
                  "\$${int.parse(amount) - 2}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 76.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 158.w),
          child: Text(
            "THANK YOU",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(
          height: 51.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 54.w),
          child: Text(
            'WELCOME TO UNIVERSE BANK',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(
          height: 51.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 107.w),
          child: Text(
            'UNIVERSEBANK.COM',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
      ],
    );
  }
}
