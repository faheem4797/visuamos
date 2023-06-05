import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visuamos/data/db/visionBoardDatabase.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/customTextFormField.dart';

class AddVisionBoard extends StatefulWidget {
  const AddVisionBoard({super.key});

  @override
  State<AddVisionBoard> createState() => _AddVisionBoardState();
}

class _AddVisionBoardState extends State<AddVisionBoard> {
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

  Random random = Random();
  late String folderPath;

  init() async {
    _crudStorage = VisionBoardDB(dbName: 'visionBoarddb.sqlite');
    _crudStorage.open(user!.uid);
    String folderName = (random.nextInt(900000) + 100000).toString();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String pathOfFolder = '${appDocDir.path}/$folderName';
    setState(() {
      folderPath = pathOfFolder;
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
    fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
                    width: 270.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: purplePopupButton,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.insert_photo_outlined),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Pick Images',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
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
                  SizedBox(height: 35.h),
                  SizedBox(
                    width: 230.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            backgroundColor: bluePopupButton,
                            textStyle: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w500)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          child: Text(
                            'Generate Vision Board',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () async {
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
    );
  }
}
