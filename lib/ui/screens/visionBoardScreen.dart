import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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
                                        image1!,
                                        image2!,
                                        image3!,
                                        image4!,
                                        image5!,
                                        image6!,
                                        image7!,
                                        image8!,
                                        fileNameController.text
                                            .replaceAll(" ", ""));
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
