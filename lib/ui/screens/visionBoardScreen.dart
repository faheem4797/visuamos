import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visuamos/data/db/database.dart';
import 'package:visuamos/data/db/visionBoardDatabase.dart';
import 'package:visuamos/data/models/simpleImageData.dart';
import 'package:visuamos/data/models/visionBoardData.dart';
import 'package:visuamos/ui/screens/sample_vision_board.dart';
import 'package:visuamos/ui/screens/simple_image_preview.dart';
import 'package:visuamos/ui/screens/visionBoardPreview.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:visuamos/ui/widgets/balanceSlipWidget.dart';
import 'package:visuamos/ui/widgets/commonBottomButton.dart';
import 'package:http/http.dart' as http;

import '../colors/colors.dart';
import '../widgets/customTextFormField.dart';

class VisionBoardScreen extends StatefulWidget {
  const VisionBoardScreen({super.key});

  @override
  State<VisionBoardScreen> createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen> {
  Map<String, dynamic>? paymentIntentData;

  final User? user = FirebaseAuth.instance.currentUser;
  late final VisionBoardDB _crudStorage;
  final ImagePicker _picker = ImagePicker();
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  String? image7;
  String? image8;
  final formKey = GlobalKey<FormState>();
  TextEditingController fileNameController = TextEditingController();

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
    fileNameController.dispose();
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
                                                          primary: black,
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
            Center(
              child: CommonBottomButton(
                title: const Text(
                  'Add a Vision Board',
                  textAlign: TextAlign.center,
                ),
                bottomButtonCallBackFunc: () async {
                  await customModalBottomSheet(context);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: CommonBottomButton(
                title: const Text(
                  'Sample Vision Board',
                  textAlign: TextAlign.center,
                ),
                bottomButtonCallBackFunc: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SampleVisionBoard(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  customModalBottomSheet(BuildContext context) async {
    Random random = Random();
    String folderName = (random.nextInt(900000) + 100000).toString();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String folderPath = '${appDocDir.path}/$folderName';
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBarEveryWhere(
          isIconRequired: true,
          callBackFunc: () {
            logoutAndPushLoginScreen(context);
          },
          title: 'Vision Board',
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: fileNameController,
                      hintText: 'Enter board name here',
                      labelText: 'Vision Board Name',
                      validator: (value) {
                        if (fileNameController.text == '') {
                          return 'Please enter a vision board name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    Center(
                      child: CommonBottomButton(
                          title: const Text(
                            'Pick Images',
                            textAlign: TextAlign.center,
                          ),
                          bottomButtonCallBackFunc: () async {
                            List<XFile> images = await _picker.pickMultiImage();
                            print('here');

                            if (images.length == 8) {
                              File fileOne =
                                  await File(folderPath + '/img001.jpg')
                                      .create(recursive: true);
                              print(fileOne.path);
                              await fileOne
                                  .writeAsBytes(await images[0].readAsBytes());
                              File fileTwo = File(folderPath + '/img002.jpg');
                              await fileTwo
                                  .writeAsBytes(await images[1].readAsBytes());
                              File fileThree = File(folderPath + '/img003.jpg');
                              await fileThree
                                  .writeAsBytes(await images[2].readAsBytes());
                              File fileFour = File(folderPath + '/img004.jpg');
                              await fileFour
                                  .writeAsBytes(await images[3].readAsBytes());
                              File fileFive = File(folderPath + '/img005.jpg');
                              await fileFive
                                  .writeAsBytes(await images[4].readAsBytes());
                              File fileSix = File(folderPath + '/img006.jpg');
                              await fileSix
                                  .writeAsBytes(await images[5].readAsBytes());
                              File fileSeven = File(folderPath + '/img007.jpg');
                              await fileSeven
                                  .writeAsBytes(await images[6].readAsBytes());
                              File fileEight = File(folderPath + '/img008.jpg');
                              await fileEight
                                  .writeAsBytes(await images[7].readAsBytes());

                              setState(() {
                                image1 = fileOne.path;
                                image2 = fileTwo.path;
                                image3 = fileThree.path;
                                image4 = fileFour.path;
                                image5 = fileFive.path;
                                image6 = fileSix.path;
                                image7 = fileSeven.path;
                                image8 = fileEight.path;
                              });
                            }
                          }),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Center(
                        child: Text(
                      'Please pick 8 images to create a vision board.',
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(height: 15.h),
                    Center(
                      child: CommonBottomButton(
                          title: const Text(
                            'Generate a Vision Board',
                            textAlign: TextAlign.center,
                          ),
                          bottomButtonCallBackFunc: () async {
                            final isValid = formKey.currentState?.validate();
                            if (isValid == true) {
                              if (image1 != null &&
                                  image2 != null &&
                                  image3 != null &&
                                  image4 != null &&
                                  image5 != null &&
                                  image6 != null &&
                                  image7 != null &&
                                  image8 != null) {
                                var a =
                                    await _crudStorage.addVisionBoardImageData(
                                  user!.uid,
                                  image1!,
                                  image2!,
                                  image3!,
                                  image4!,
                                  image5!,
                                  image6!,
                                  image7!,
                                  image8!,
                                  fileNameController.text.replaceAll(" ", ""),
                                  (user?.uid == 'MsWSztJZpLSQBeRfu0yKWhismu22')
                                      ? 1
                                      : 0,
                                  '', // coupon
                                );
                                print(a);
                                setState(() {
                                  fileNameController.clear();
                                });

                                Navigator.pop(context);
                              }
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
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
