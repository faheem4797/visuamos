import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:visuamos/data/db/visionBoardDatabase.dart';
import 'package:visuamos/data/models/visionBoardData.dart';
import 'package:visuamos/ui/screens/visionBoardPreview.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:http/http.dart' as http;

import '../colors/colors.dart';

class VisionBoardScreen extends StatefulWidget {
  const VisionBoardScreen({super.key});

  @override
  State<VisionBoardScreen> createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen> {
  Map<String, dynamic>? paymentIntentData;

  final User? user = FirebaseAuth.instance.currentUser;
  late final VisionBoardDB _crudStorage;

  init() async {
    _crudStorage = VisionBoardDB(dbName: 'visionBoarddb.sqlite');
    _crudStorage.open(user!.uid);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _crudStorage.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarEveryWhere(
          title: 'Vision Boards',
          isIconRequired: true,
          callBackFunc: () {
            logoutAndPushLoginScreen(context);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<VisionBoardData>>(
                  stream: _crudStorage.all,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data added yet'),
                      );
                    } else if (snapshot.data!.isNotEmpty) {
                      return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 5.h),
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Image',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Image',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: snapshot.data!
                                  .map(
                                    (data) => DataRow(
                                      cells: [
                                        DataCell(Center(
                                          child: Image.file(
                                            File(data.image1),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )),
                                        DataCell(Center(
                                          child: Image.file(
                                            File(data.image2),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )),
                                        DataCell(
                                          //Preview Button
                                          (data.isPaid == 0)
                                              ? ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          backgroundColor:
                                                              black,
                                                          textStyle: TextStyle(
                                                              fontSize: 24.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  onPressed: () async {
                                                    await makePayment(
                                                        '6.99', data);
                                                  },
                                                  child: const Text('Pay'),
                                                )
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          backgroundColor:
                                                              black,
                                                          textStyle: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              VisionBoardPreview(
                                                                image1:
                                                                    data.image1,
                                                                image2:
                                                                    data.image2,
                                                                image3:
                                                                    data.image3,
                                                                image4:
                                                                    data.image4,
                                                                image5:
                                                                    data.image5,
                                                                image6:
                                                                    data.image6,
                                                                image7:
                                                                    data.image7,
                                                                image8:
                                                                    data.image8,
                                                                fileName: data
                                                                    .fileName,
                                                              )),
                                                    );
                                                  },
                                                  child: const Text('Preview')),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ));
                    } else {
                      print('in this section');
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount, VisionBoardData data) async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret:
                      //'sk_test_51MMw6GBP9cs9PLZwrM7rkNJoGKi80CTAyWJmejjAPKaFtaIY73pYGHFGO8AZtQfUL4GnMm3CagGchLheAX18s0Mh00iZb8QCnP',
                      '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',
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  //applePay: PaymentSheetApplePay.,
                  //googlePay: true,
                  //testEnv: true,
                  //customFlow: true,
                  style: ThemeMode.dark,
                  //merchantCountryCode: 'US',
                  merchantDisplayName: 'Visuamos'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(data);
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  displayPaymentSheet(VisionBoardData data) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              //       parameters: PresentPaymentSheetParameters(
              // clientSecret: paymentIntentData!['client_secret'],
              // confirmPayment: true,
              // )
              )
          .then((newValue) async {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Paid Successfully")));
        await _crudStorage.update(
          data.id!,
          user!.uid,
          //data.isPaid,
          1,
        );

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Cancelled")));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ' +
                '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',
            //'sk_test_51MMw6GBP9cs9PLZwrM7rkNJoGKi80CTAyWJmejjAPKaFtaIY73pYGHFGO8AZtQfUL4GnMm3CagGchLheAX18s0Mh00iZb8QCnP',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = ((double.parse(amount)) * 100).toInt();
    return a.toString();
  }
}
