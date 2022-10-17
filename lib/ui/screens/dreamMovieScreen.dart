import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:visuamos/data/db/movieDatabase.dart';
import 'package:visuamos/data/models/dreamMovieData.dart';
import 'package:visuamos/ui/screens/dreamMoviePreview.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:visuamos/ui/widgets/commonBottomButton.dart';
import '../colors/colors.dart';
import '../widgets/customTextFormField.dart';

class DreamMovieScreen extends StatefulWidget {
  const DreamMovieScreen({super.key});

  @override
  State<DreamMovieScreen> createState() => _DreamMovieScreenState();
}

class _DreamMovieScreenState extends State<DreamMovieScreen> {
  late final DreamMovieDB _crudStorage;
  final ImagePicker _picker = ImagePicker();
  String? image1;
  String? image2;
  String? image3;
  String? audio;
  final formKey = GlobalKey<FormState>();
  TextEditingController caption1Controller = TextEditingController();
  TextEditingController caption2Controller = TextEditingController();
  TextEditingController caption3Controller = TextEditingController();

  @override
  void initState() {
    _crudStorage = DreamMovieDB(dbName: 'dreamMoviedb.sqlite');
    _crudStorage.open();
    super.initState();
  }

  @override
  void dispose() {
    _crudStorage.close();
    caption1Controller.dispose();
    caption2Controller.dispose();
    caption3Controller.dispose();
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
                                          child: Image.memory(
                                            base64Decode(data.image1),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )),
                                        DataCell(Center(
                                          child: Text(data.caption1),
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
                                                          DreamMoviePreview(
                                                              image1:
                                                                  data.image1,
                                                              image2:
                                                                  data.image2,
                                                              image3:
                                                                  data.image3,
                                                              caption1:
                                                                  data.caption1,
                                                              caption2:
                                                                  data.caption2,
                                                              caption3:
                                                                  data.caption3,
                                                              audio:
                                                                  data.audio)),
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
                title: 'Add a Dream Movie',
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
          title: 'Dream Movies',
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
                    Center(
                      child: CommonBottomButton(
                          title: 'Pick Images',
                          bottomButtonCallBackFunc: () async {
                            List<XFile> images = await _picker.pickMultiImage();

                            if (images.length == 3) {
                              print('here');
                              final tempImage1 =
                                  base64Encode(await images[0].readAsBytes());
                              final tempImage2 =
                                  base64Encode(await images[1].readAsBytes());
                              final tempImage3 =
                                  base64Encode(await images[2].readAsBytes());

                              setState(() {
                                image1 = tempImage1;
                                image2 = tempImage2;
                                image3 = tempImage3;
                              });
                            }
                          }),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Center(
                        child: Text(
                      'Please pick 3 images to create a dream movie.',
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: CommonBottomButton(
                          title: 'Pick Audio',
                          bottomButtonCallBackFunc: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['mp3'],
                            );

                            if (result != null && result.files.length == 1) {
                              File file = File(result.files.first.path!);
                              var contents = await file.readAsBytes();

                              final tempAudio = base64Encode(contents);

                              print(tempAudio);

                              setState(() {
                                audio = tempAudio;
                              });
                            }
                          }),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      controller: caption1Controller,
                      hintText: 'Enter caption 1 here',
                      labelText: 'Caption 1',
                      validator: (value) {
                        if (caption1Controller.text == '') {
                          return 'Please enter a caption';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      controller: caption2Controller,
                      hintText: 'Enter caption 2 here',
                      labelText: 'Caption 2',
                      validator: (value) {
                        if (caption2Controller.text == '') {
                          return 'Please enter a caption';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      controller: caption3Controller,
                      hintText: 'Enter caption 3 here',
                      labelText: 'Caption 3',
                      validator: (value) {
                        if (caption3Controller.text == '') {
                          return 'Please enter a caption';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    Center(
                      child: CommonBottomButton(
                          title: 'Generate a Dream Movie',
                          bottomButtonCallBackFunc: () async {
                            final isValid = formKey.currentState?.validate();
                            if (isValid == true) {
                              if (image1 != null &&
                                  image2 != null &&
                                  image3 != null &&
                                  audio != null &&
                                  caption1Controller.text != '' &&
                                  caption2Controller.text != '' &&
                                  caption3Controller.text != '') {
                                var a = await _crudStorage.addDreamMovieData(
                                  image1!,
                                  image2!,
                                  image3!,
                                  caption1Controller.text,
                                  caption2Controller.text,
                                  caption3Controller.text,
                                  audio!,
                                );
                                print(a);
                                setState(() {
                                  caption1Controller.clear();
                                  caption2Controller.clear();
                                  caption3Controller.clear();
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
