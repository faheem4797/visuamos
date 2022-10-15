import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:visuamos/data/db/database.dart';
import 'package:visuamos/data/db/visionBoardDatabase.dart';
import 'package:visuamos/data/models/simpleImageData.dart';
import 'package:visuamos/data/models/visionBoardData.dart';
import 'package:visuamos/ui/screens/simple_image_preview.dart';
import 'package:visuamos/ui/screens/visionBoardPreview.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:visuamos/ui/widgets/balanceSlipWidget.dart';
import 'package:visuamos/ui/widgets/commonBottomButton.dart';
import '../colors/colors.dart';
import '../widgets/customTextFormField.dart';

class VisionBoardScreen extends StatefulWidget {
  const VisionBoardScreen({super.key});

  @override
  State<VisionBoardScreen> createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen> {
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

  @override
  void initState() {
    _crudStorage = VisionBoardDB(dbName: 'visionBoarddb.sqlite');
    _crudStorage.open();
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
                          padding: const EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Image 1',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Image 2',
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
                                          child: Image.memory(
                                            base64Decode(data.image1),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )),
                                        DataCell(Center(
                                          child: Image.memory(
                                            base64Decode(data.image2),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )),
                                        DataCell(
                                          //Prebiew Button
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                  primary: black,
                                                  textStyle: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VisionBoardPreview(
                                                            image1: data.image1,
                                                            image2: data.image2,
                                                            image3: data.image3,
                                                            image4: data.image4,
                                                            image5: data.image5,
                                                            image6: data.image6,
                                                            image7: data.image7,
                                                            image8: data.image8,
                                                            fileName:
                                                                data.fileName,
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
            const SizedBox(
              height: 10,
            ),
            Center(
              child: CommonBottomButton(
                title: 'Add a Vision Board',
                bottomButtonCallBackFunc: () async {
                  await customModalBottomSheet(context);
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
                    Center(
                      child: CommonBottomButton(
                          title: 'Pick Images',
                          bottomButtonCallBackFunc: () async {
                            List<XFile> images = await _picker.pickMultiImage();
                            print('here');

                            if (images.length == 8) {
                              final tempImage1 =
                                  base64Encode(await images[0].readAsBytes());
                              final tempImage2 =
                                  base64Encode(await images[1].readAsBytes());
                              final tempImage3 =
                                  base64Encode(await images[2].readAsBytes());
                              final tempImage4 =
                                  base64Encode(await images[3].readAsBytes());
                              final tempImage5 =
                                  base64Encode(await images[4].readAsBytes());
                              final tempImage6 =
                                  base64Encode(await images[5].readAsBytes());
                              final tempImage7 =
                                  base64Encode(await images[6].readAsBytes());
                              final tempImage8 =
                                  base64Encode(await images[7].readAsBytes());

                              setState(() {
                                image1 = tempImage1;
                                image2 = tempImage2;
                                image3 = tempImage3;
                                image4 = tempImage4;
                                image5 = tempImage5;
                                image6 = tempImage6;
                                image7 = tempImage7;
                                image8 = tempImage8;
                              });
                            }
                          }),
                    ),
                    Center(
                      child: CommonBottomButton(
                          title: 'Generate a Vision Board',
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
                                        image1!,
                                        image2!,
                                        image3!,
                                        image4!,
                                        image5!,
                                        image6!,
                                        image7!,
                                        image8!,
                                        fileNameController.text);
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
}
