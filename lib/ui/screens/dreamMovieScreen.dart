import 'dart:convert';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visuamos/data/db/movieDatabase.dart';
import 'package:visuamos/data/models/dreamMovieData.dart';
import 'package:visuamos/ui/screens/dreamMoviePreview.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:http/http.dart' as http;

import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import '../colors/colors.dart';

class DreamMovieScreen extends StatefulWidget {
  const DreamMovieScreen({super.key});

  @override
  State<DreamMovieScreen> createState() => _DreamMovieScreenState();
}

class _DreamMovieScreenState extends State<DreamMovieScreen> {
  Map<String, dynamic>? paymentIntentData;

  final User? user = FirebaseAuth.instance.currentUser;
  late final DreamMovieDB _crudStorage;

  init() async {
    _crudStorage = DreamMovieDB(dbName: 'dreamMoviedb.sqlite');
    _crudStorage.open(user!.uid);

    FFmpegKitConfig.init().then((_) {
      var fontNameMapping = Map<String, String>();
      fontNameMapping["MyFontName"] = "Doppio One";

      FFmpegKitConfig.setFontDirectoryList(
          ["/system/fonts", "/System/Library/Fonts"]);
    });
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
          title: 'Dream Movie',
          isIconRequired: true,
          callBackFunc: () {
            logoutAndPushLoginScreen(context);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<DreamMovieData>>(
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
                      print(snapshot.data);

                      return Container(
                          padding: const EdgeInsets.all(5),
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
                                    'Caption',
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
                                          child: Text(data.caption1),
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
                                                        '9.99', data);
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
                                                  onPressed: () async {
                                                    // String img1 =
                                                    //     await base64Encode(
                                                    //         await File(data.image1)
                                                    //             .readAsBytes());
                                                    // String img2 =
                                                    //     await base64Encode(
                                                    //         await File(data.image2)
                                                    //             .readAsBytes());
                                                    // String img3 =
                                                    //     await base64Encode(
                                                    //         await File(data.image3)
                                                    //             .readAsBytes());
                                                    // String img4 =
                                                    //     await base64Encode(
                                                    //         await File(data.image4)
                                                    //             .readAsBytes());
                                                    // String img5 =
                                                    //     await base64Encode(
                                                    //         await File(data.image5)
                                                    //             .readAsBytes());
                                                    // String img6 =
                                                    //     await base64Encode(
                                                    //         await File(data.image6)
                                                    //             .readAsBytes());
                                                    // String img7 =
                                                    //     await base64Encode(
                                                    //         await File(data.image7)
                                                    //             .readAsBytes());
                                                    // String img8 =
                                                    //     await base64Encode(
                                                    //         await File(data.image8)
                                                    //             .readAsBytes());
                                                    // String img9 =
                                                    //     await base64Encode(
                                                    //         await File(data.image9)
                                                    //             .readAsBytes());
                                                    // String img10 =
                                                    //     await base64Encode(
                                                    //         await File(data.image10)
                                                    //             .readAsBytes());

                                                    // ignore: use_build_context_synchronously
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DreamMoviePreview(
                                                                folderName: data
                                                                    .image1
                                                                    .substring(
                                                                        0,
                                                                        data.image1.length -
                                                                            10),
                                                                // image1: img1,
                                                                // image2: img2,
                                                                // image3: img3,
                                                                // image4: img4,
                                                                // image5: img5,
                                                                // image6: img6,
                                                                // image7: img7,
                                                                // image8: img8,
                                                                // image9: img9,
                                                                // image10: img10,
                                                                // caption1: data
                                                                //     .caption1,
                                                                // caption2: data
                                                                //     .caption2,
                                                                // caption3: data
                                                                //     .caption3,
                                                                // caption4: data
                                                                //     .caption4,
                                                                // caption5: data
                                                                //     .caption5,
                                                                // caption6:
                                                                //     data.caption6,
                                                                // caption7:
                                                                //     data.caption7,
                                                                // caption8:
                                                                //     data.caption8,
                                                                // caption9:
                                                                //     data.caption9,
                                                                // caption10: data
                                                                //     .caption10,
                                                                // audio:
                                                                //     data.audio
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

  Future<void> makePayment(String amount, DreamMovieData data) async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret:
                      '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',
                  //'sk_test_51MMw6GBP9cs9PLZwrM7rkNJoGKi80CTAyWJmejjAPKaFtaIY73pYGHFGO8AZtQfUL4GnMm3CagGchLheAX18s0Mh00iZb8QCnP',
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

  displayPaymentSheet(DreamMovieData data) async {
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
            // 'sk_test_51MMw6GBP9cs9PLZwrM7rkNJoGKi80CTAyWJmejjAPKaFtaIY73pYGHFGO8AZtQfUL4GnMm3CagGchLheAX18s0Mh00iZb8QCnP',
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
