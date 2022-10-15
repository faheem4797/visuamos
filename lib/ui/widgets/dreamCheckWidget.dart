import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:visuamos/ui/colors/colors.dart';

class DreamCheckWidget extends StatelessWidget {
  final String date;
  final String amount;
  final String name;
  const DreamCheckWidget(
      {super.key,
      required this.date,
      required this.amount,
      required this.name});

  String capitalizeFirstWord(String string) {
    List<String> stringList = string.split(' ');
    for (var i = 0; i < stringList.length; i++) {
      String temp = stringList[i];
      temp = temp[0].toUpperCase() + temp.substring(1);
      stringList[i] = temp;
    }
    final capitalizedString = stringList.join(' ');
    return capitalizedString;
  }

  String numberToWord(String number) {
    if (number.contains('.')) {
      List<String> splitList = number.split('.');
      String beforeDecimal =
          NumberToWordsEnglish.convert(int.parse(splitList[0]));
      beforeDecimal = capitalizeFirstWord(beforeDecimal);
      String afterDecimal =
          NumberToWordsEnglish.convert(int.parse(splitList[1]));
      afterDecimal = capitalizeFirstWord(afterDecimal);
      final finalString = beforeDecimal + ' and ' + afterDecimal + ' cents';
      return finalString;
    } else {
      String amount = NumberToWordsEnglish.convert(int.parse(number));
      amount = capitalizeFirstWord(amount);
      return amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 285.h,
        width: 428.w,
        color: lightYellow,
        child: Container(
          height: 280.h,
          width: 423.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 12.h),
          decoration: BoxDecoration(border: Border.all(color: black)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        'UNIVERSE BANK',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'LOCATION: 1733 AVAILABLE ST. ANYTIME, UN 81733',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 9.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'This is not subject to Article 3 of the UCC',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 8.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Your Wish is My Command',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 8.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'DATE',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                            fontFamily: 'Merriweather',
                          ),
                        ),
                        SizedBox(width: 3.w),
                        SizedBox(
                          height: 20.h,
                          child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    date,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      fontFamily: 'Merriweather',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    '__________',
                                    style: TextStyle(
                                      color: grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      fontFamily: 'Merriweather',
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    'PAY TO THE ORDER OF',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      fontFamily: 'Merriweather',
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    height: 20.h,
                    child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                fontFamily: 'Merriweather',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '__________',
                              style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const Spacer(),
                  Container(
                    height: 25.h,
                    width: 100.w,
                    color: white,
                    child: Center(
                      child: Text(
                        '\$$amount',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 300.w,
                    child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              numberToWord(amount),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                fontFamily: 'Merriweather',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '__________________________________________________________________________________________________________________________________',
                              style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'DOLLARS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      fontFamily: 'Merriweather',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7.h,
              ),
              Row(
                children: [
                  Text(
                    'MEMO',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      fontFamily: 'Merriweather',
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  SizedBox(
                    height: 20.h,
                    child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Services Rendered',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                fontFamily: 'Merriweather',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '_____________',
                              style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            'SIGNED BY:',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              fontFamily: 'Merriweather',
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                            child: Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'assets/signature.png',
                                      height: 40.h,
                                      width: 80.w,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      '__________',
                                      style: TextStyle(
                                        color: grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        fontFamily: 'Merriweather',
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'REMINDER:   ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              fontFamily: 'Merriweather',
                            ),
                          ),
                          Text(
                            'YOUR MONEY IN THIS\nACCOUNT IS UNLIMITED',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              fontFamily: 'Merriweather',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
