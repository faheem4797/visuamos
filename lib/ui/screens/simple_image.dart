import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:visuamos/data/db/database.dart';
import 'package:visuamos/data/models/simpleImageData.dart';
import 'package:visuamos/ui/screens/simple_image_preview.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:http/http.dart' as http;

import '../colors/colors.dart';

class SimpleImage extends StatefulWidget {
  final int imageType;

  const SimpleImage({super.key, required this.imageType});

  @override
  State<SimpleImage> createState() => _SimpleImageState();
}

class _SimpleImageState extends State<SimpleImage> {
  Map<String, dynamic>? paymentIntentData;
  final User? user = FirebaseAuth.instance.currentUser;

  late final VisuamosDB _crudStorage;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController couponController = TextEditingController();

  void init() async {
    _crudStorage = VisuamosDB(dbName: 'visuamosdb.sqlite');
    (widget.imageType == 0)
        ? _crudStorage.open(0, user!.uid)
        : (widget.imageType == 1)
            ? _crudStorage.open(1, user!.uid)
            : _crudStorage.open(2, user!.uid);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _crudStorage.close();
    nameController.dispose();
    amountController.dispose();
    dateController.dispose();
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarEveryWhere(
          title: (widget.imageType == 0)
              ? 'Balance Slips'
              : (widget.imageType == 1)
                  ? 'Bank Statements'
                  : 'Dream Checks',
          isIconRequired: true,
          callBackFunc: () {
            logoutAndPushLoginScreen(context);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<SimpleImageData>>(
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
                          padding: const EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: FittedBox(
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Amount',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Date',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                rows: snapshot.data!
                                    .map(
                                      (data) => DataRow(
                                        cells: [
                                          DataCell(Text(
                                            //Name
                                            data.name,
                                            style: TextStyle(fontSize: 22.sp),
                                          )),
                                          DataCell(Text(
                                            //Amount
                                            data.amount,
                                            style: TextStyle(fontSize: 22.sp),
                                          )),
                                          DataCell(
                                            Text(
                                              //Date
                                              data.date,
                                              style: TextStyle(fontSize: 22.sp),
                                            ),
                                          ),
                                          DataCell(
                                            //Preview Button

                                            (data.isPaid == 0)
                                                ?
                                                // GooglePayButton(
                                                //     paymentConfigurationAsset:
                                                //         'gpay.json',
                                                //     paymentItems: _paymentItems,
                                                //     type:
                                                //         GooglePayButtonType.pay,
                                                //     margin:
                                                //         const EdgeInsets.only(
                                                //             top: 15.0),
                                                //     onPaymentResult: (result) {
                                                //       print(result);
                                                //       _crudStorage.update(
                                                //           data.id!,
                                                //           user!.uid,
                                                //           //data.isPaid,
                                                //           1,
                                                //           data.imageType);
                                                //     },
                                                //     loadingIndicator:
                                                //         const Center(
                                                //       child:
                                                //           CircularProgressIndicator(),
                                                //     ),
                                                //   )
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
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
                                                          (widget.imageType ==
                                                                  0)
                                                              ? '3.99'
                                                              : (widget.imageType ==
                                                                      1)
                                                                  ? '4.99'
                                                                  : '3.99',
                                                          data);
                                                    },
                                                    child: const Text('Pay'),
                                                  )
                                                : ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
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
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SimpleImagePreview(
                                                                  name:
                                                                      data.name,
                                                                  fileName:
                                                                      data.name,
                                                                  date:
                                                                      data.date,
                                                                  amount: data
                                                                      .amount,
                                                                  imageType: widget
                                                                      .imageType,
                                                                )),
                                                      );
                                                    },
                                                    child:
                                                        const Text('Preview'),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
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
            const SizedBox(
              height: 10,
            ),
            // Center(
            //   child: CommonBottomButton(
            //     title: (widget.imageType == 0)
            //         ? const Text(
            //             'Add a Balance Slip',
            //             textAlign: TextAlign.center,
            //           )
            //         : (widget.imageType == 1)
            //             ? const Text(
            //                 'Add a Bank Statement',
            //                 textAlign: TextAlign.center,
            //               )
            //             : const Text(
            //                 'Add a Dream Check',
            //                 textAlign: TextAlign.center,
            //               ),
            //     bottomButtonCallBackFunc: () async {
            //       await customModalBottomSheet(context);
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Center(
            //   child: CommonBottomButton(
            //     title: (widget.imageType == 0)
            //         ? const Text(
            //             'Sample Balance Slip',
            //             textAlign: TextAlign.center,
            //           )
            //         : (widget.imageType == 1)
            //             ? const Text(
            //                 'Sample Bank Statement',
            //                 textAlign: TextAlign.center,
            //               )
            //             : const Text(
            //                 'Sample Dream Check',
            //                 textAlign: TextAlign.center,
            //               ),
            //     bottomButtonCallBackFunc: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 SampleSimpleImage(imageType: widget.imageType)),
            //       );
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        ),
      ),
    );
  }

  // customModalBottomSheet(BuildContext context) async {
  //   showMaterialModalBottomSheet(
  //     context: context,
  //     builder: (context) => Scaffold(
  //       appBar: AppBarEveryWhere(
  //         isIconRequired: true,
  //         callBackFunc: () {
  //           logoutAndPushLoginScreen(context);
  //         },
  //         title: (widget.imageType == 0)
  //             ? 'Balance Slips'
  //             : (widget.imageType == 1)
  //                 ? 'Bank Statements'
  //                 : 'Dream Checks',
  //       ),
  //       body: Center(
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //             child: Form(
  //               key: formKey,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   CustomTextFormField(
  //                     controller: nameController,
  //                     hintText: 'Enter your name here',
  //                     labelText: 'Name',
  //                     validator: (value) {
  //                       if (nameController.text == '') {
  //                         return 'Please enter a name';
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   CustomTextFormField(
  //                     hintText: 'Enter the amount here',
  //                     labelText: 'Amount',
  //                     controller: amountController,
  //                     textInputType: TextInputType.number,
  //                     validator: (value) {
  //                       if (amountController.text == '') {
  //                         return 'Please enter an amount';
  //                       } else if (amountController.text
  //                           .contains(RegExp('[a-zA-Z]'))) {
  //                         return 'Please enter a valid amount';
  //                       } else if (('.'
  //                               .allMatches(amountController.text)
  //                               .length) >
  //                           1) {
  //                         return 'Please enter a valid amount';
  //                       } else if (!amountController.text.contains(RegExp(
  //                           "^[0-9]+(([.]?[0-9]*)?|([ ]?[0-9]*[/]?[0-9]*)?)?"))) {
  //                         return 'Please enter a valid amount';
  //                       } else if (amountController.text != '') {
  //                         final temp = amountController.text.split('');
  //                         temp[0].contains('.');
  //                         if (temp[0].contains('.')) {
  //                           return 'Please enter a valid amount';
  //                         } else if (temp.last == '.') {
  //                           return 'Please enter a valid amount';
  //                         }
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   CustomTextFormField(
  //                       controller: dateController,
  //                       hintText: 'Enter date here',
  //                       labelText: 'Date',
  //                       readOnly: true,
  //                       validator: (value) {
  //                         if (dateController.text == '') {
  //                           return 'Please enter a date';
  //                         } else {
  //                           return null;
  //                         }
  //                       },
  //                       onTap: () async {
  //                         DateTime? pickedDate = await showDatePicker(
  //                             context: context,
  //                             initialDate: DateTime.now(),
  //                             firstDate: DateTime(2000),
  //                             lastDate: DateTime(2101));
  //                         if (pickedDate != null) {
  //                           String formattedDate =
  //                               DateFormat('dd-MM-yyyy').format(pickedDate);
  //                           setState(() {
  //                             dateController.text = formattedDate;
  //                           });
  //                         }
  //                       }),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   CustomTextFormField(
  //                     controller: couponController,
  //                     hintText: 'Enter your coupon here',
  //                     labelText: 'Coupon',
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Center(
  //                     child: CommonBottomButton(
  //                         title: (widget.imageType == 0)
  //                             ? const Text(
  //                                 'Generate Balance Slip',
  //                                 textAlign: TextAlign.center,
  //                               )
  //                             : (widget.imageType == 1)
  //                                 ? const Text(
  //                                     'Generate Bank Statement',
  //                                     textAlign: TextAlign.center,
  //                                   )
  //                                 : const Text(
  //                                     'Generate Dream Check',
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                         bottomButtonCallBackFunc: () async {
  //                           final isValid = formKey.currentState?.validate();
  //                           if (isValid == true) {
  //                             formKey.currentState?.save();

  //                             var a = await _crudStorage.addImageData(
  //                               user!.uid,
  //                               nameController.text,
  //                               amountController.text,
  //                               dateController.text,
  //                               (user?.uid == 'MsWSztJZpLSQBeRfu0yKWhismu22')
  //                                   ? 1
  //                                   : 0,
  //                               //(couponController.text == 'free') ? 1 : 0,
  //                               couponController.text,
  //                               widget.imageType,
  //                             );
  //                             print(a);
  //                             setState(() {
  //                               nameController.clear();
  //                               amountController.clear();
  //                               dateController.clear();
  //                               couponController.clear();
  //                             });
  //                             Navigator.pop(context);
  //                           }
  //                         }),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future<void> makePayment(String amount, SimpleImageData data) async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret:
                      // 'sk_test_51MMw6GBP9cs9PLZwrM7rkNJoGKi80CTAyWJmejjAPKaFtaIY73pYGHFGO8AZtQfUL4GnMm3CagGchLheAX18s0Mh00iZb8QCnP'
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

  displayPaymentSheet(SimpleImageData data) async {
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
            data.imageType);

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
