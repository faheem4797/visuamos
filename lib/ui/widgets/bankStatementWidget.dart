import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/ui/colors/colors.dart';

class BankStatementWidget extends StatefulWidget {
  final String date;
  final String amount;
  final String name;
  final String prevDate;
  const BankStatementWidget({
    super.key,
    required this.date,
    required this.prevDate,
    required this.amount,
    required this.name,
  });

  @override
  State<BankStatementWidget> createState() => _BankStatementWidgetState();
}

class _BankStatementWidgetState extends State<BankStatementWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        //
        //
        //
        //
        //
        //
        //
        SizedBox(
          height: 19.h,
        ),
        //
        //
        //
        //
        //
        //
        //
        //

        Padding(
          padding: EdgeInsets.only(left: 64.w),
          child: Text(
            'UNIVERSE BANK',
            style: TextStyle(
              color: purple,
              fontWeight: FontWeight.w400,
              fontSize: 36.sp,
              fontFamily: 'Merriweather',
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LOCATION: 1733 AVAILABLE ST. ANYTIME, UN 81733',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              SizedBox(height: 11.h),
              Text(
                'This is not subject to Article 3 of the UCC',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              Text(
                'Your Wish is My Command',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'City: your hart',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 28.h),
                      Text(
                        'USA Small Business, LLC',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Street Number 7272',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'City: your hart',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '1234-555-5678',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 19.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 22.h),
                            Text(
                              'Account Name:',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Account Number:',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '000000012345',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Statement Period:',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            Text(
                              ' ${widget.prevDate} to ${widget.date}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                'ACCOUNT SUMMARY',
                style: TextStyle(
                  color: purple,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Balance on ${widget.date}: \$${widget.amount}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Total Money in: \$536',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Total Money out: \$471',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'End Balance: \$${int.parse(widget.amount) + 536 - 471}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  fontFamily: 'Merriweather',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 21.h),
        Container(
          color: purple,
          height: 50.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  'DATE',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  'DESCRIPTION',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 13.w),
                child: Text(
                  'WITHDRAWAL',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 11.w),
                child: Text(
                  'DEPOSIT',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  'BALANCE',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: lightGrey,
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/02',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 11.w),
                child: Text(
                  'Previous',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 232.w),
                child: Text(
                  '27,584.83',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/05',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.w),
                child: Text(
                  'Internet Bill',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 57.w),
                child: Text(
                  '75.94',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 120.w),
                child: Text(
                  '27,554.71',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: lightGrey,
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/10',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 13.w),
                child: Text(
                  'Electric Bill',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 56.w),
                child: Text(
                  '253.46',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 114.w),
                child: Text(
                  '27,676.71',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/12',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  'Card Deposit',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 146.w),
                child: Text(
                  '65.94',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Text(
                  '27,594.51',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: lightGrey,
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/15',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  'Payroll',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 83.w),
                child: Text(
                  '3875.53',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 109.w),
                child: Text(
                  '27,614.34',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/16',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 11.w),
                child: Text(
                  'Bank Deposit',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 144.w),
                child: Text(
                  '75.94',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 27.w),
                child: Text(
                  '27,554.71',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: lightGrey,
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/21',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  'Rent Bill',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 73.w),
                child: Text(
                  '750.96',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 114.w),
                child: Text(
                  '27,584.83',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  '03/24',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.w),
                child: Text(
                  'Check Deposit',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 138.w),
                child: Text(
                  '456.87',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  '27,689.71',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: purple,
          height: 50.h,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 61.w),
                child: Text(
                  'End Balance',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 211.w),
                child: Text(
                  '27,689.71',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    fontFamily: 'Merriweather',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
