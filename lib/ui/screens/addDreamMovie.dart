import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as img;
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:visuamos/data/db/movieDatabase.dart';
import 'package:visuamos/ui/colors/colors.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/CommonBottomButton.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/customTextFormField.dart';

class AddDreamMovie extends StatefulWidget {
  const AddDreamMovie({super.key});

  @override
  State<AddDreamMovie> createState() => _AddDreamMovieState();
}

class _AddDreamMovieState extends State<AddDreamMovie> {
  final User? user = FirebaseAuth.instance.currentUser;
  late final DreamMovieDB _crudStorage;
  final ImagePicker _picker = ImagePicker();
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  String? image7;
  String? image8;
  String? image9;
  String? image10;
  String? audio;
  final formKey = GlobalKey<FormState>();
  ScreenshotController screenshotController = ScreenshotController();

  TextEditingController caption1Controller = TextEditingController();
  TextEditingController caption2Controller = TextEditingController();
  TextEditingController caption3Controller = TextEditingController();
  TextEditingController caption4Controller = TextEditingController();
  TextEditingController caption5Controller = TextEditingController();
  TextEditingController caption6Controller = TextEditingController();
  TextEditingController caption7Controller = TextEditingController();
  TextEditingController caption8Controller = TextEditingController();
  TextEditingController caption9Controller = TextEditingController();
  TextEditingController caption10Controller = TextEditingController();
  bool screenshotInProgress = false;
  bool? imagesSelectedError;
  bool? audioSelectedError;
  Random random = Random();
  late String folderPath;

  init() async {
    _crudStorage = DreamMovieDB(dbName: 'dreamMoviedb.sqlite');
    _crudStorage.open(user!.uid);

    FFmpegKitConfig.init().then((_) {
      var fontNameMapping = Map<String, String>();
      fontNameMapping["MyFontName"] = "Doppio One";

      FFmpegKitConfig.setFontDirectoryList(
          ["/system/fonts", "/System/Library/Fonts"]);
    });
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
    caption1Controller.dispose();
    caption2Controller.dispose();
    caption3Controller.dispose();
    caption4Controller.dispose();
    caption5Controller.dispose();
    caption6Controller.dispose();
    caption7Controller.dispose();
    caption8Controller.dispose();
    caption9Controller.dispose();
    caption10Controller.dispose();
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
        title: 'Add Dream Movie',
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
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          List<XFile> images = await _picker.pickMultiImage();

                          if (images.length == 10) {
                            //
                            //
                            //
                            // Need to store the image into the mobile directory first and then
                            // need to get the file path of those images and store them to the DB and then
                            // need to retrieve those files accordingly on previewing
                            //
                            //
                            //
                            print('here');

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
                            File fileNine = File(folderPath + '/img009.jpg');
                            await fileNine
                                .writeAsBytes(await images[8].readAsBytes());
                            File fileTen = File(folderPath + '/img010.jpg');
                            await fileTen
                                .writeAsBytes(await images[9].readAsBytes());

                            setState(() {
                              image1 = fileOne.path;
                              image2 = fileTwo.path;
                              image3 = fileThree.path;
                              image4 = fileFour.path;
                              image5 = fileFive.path;
                              image6 = fileSix.path;
                              image7 = fileSeven.path;
                              image8 = fileEight.path;
                              image9 = fileNine.path;
                              image10 = fileTen.path;
                            });

                            setState(() {
                              imagesSelectedError = false;
                            });
                          }
                        }),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  (imagesSelectedError == true)
                      ? const Center(
                          child: Text(
                            'Images not selected',
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const Center(),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Center(
                      child: Text(
                    'Please pick 10 images to create a dream movie.',
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
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
                              Icon(Icons.audiotrack),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Pick Audio',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        // : const Text(
                        //   'Pick Audio',
                        //   textAlign: TextAlign.center,
                        // ),
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['mp3'],
                          );

                          if (result != null && result.files.length == 1) {
                            File file = File(result.files.first.path!);

                            File tempAudio =
                                await File(folderPath + '/audio.mp3')
                                    .create(recursive: true);
                            await tempAudio
                                .writeAsBytes(await file.readAsBytes());

                            print(tempAudio);

                            setState(() {
                              audio = tempAudio.path;
                            });

                            setState(() {
                              audioSelectedError = false;
                            });
                          }
                        }),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  (audioSelectedError == true)
                      ? const Center(
                          child: Text(
                            'Audio not selected',
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const Center(),
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
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: caption4Controller,
                    hintText: 'Enter caption 4 here',
                    labelText: 'Caption 4',
                    validator: (value) {
                      if (caption4Controller.text == '') {
                        return 'Please enter a caption';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: caption5Controller,
                    hintText: 'Enter caption 5 here',
                    labelText: 'Caption 5',
                    validator: (value) {
                      if (caption5Controller.text == '') {
                        return 'Please enter a caption';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: caption6Controller,
                    hintText: 'Enter caption 6 here',
                    labelText: 'Caption 6',
                    validator: (value) {
                      if (caption6Controller.text == '') {
                        return 'Please enter a caption';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: caption7Controller,
                    hintText: 'Enter caption 7 here',
                    labelText: 'Caption 7',
                    validator: (value) {
                      if (caption7Controller.text == '') {
                        return 'Please enter a caption';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: caption8Controller,
                    hintText: 'Enter caption 8 here',
                    labelText: 'Caption 8',
                    validator: (value) {
                      if (caption8Controller.text == '') {
                        return 'Please enter a caption';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: caption9Controller,
                    hintText: 'Enter caption 9 here',
                    labelText: 'Caption 9',
                    validator: (value) {
                      if (caption9Controller.text == '') {
                        return 'Please enter a caption';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    controller: caption10Controller,
                    hintText: 'Enter caption 10 here',
                    labelText: 'Caption 10',
                    validator: (value) {
                      if (caption10Controller.text == '') {
                        return 'Please enter a caption';
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
                            backgroundColor: bluePopupButton,
                            textStyle: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w500)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          child: (screenshotInProgress == true)
                              ? const Center(child: CircularProgressIndicator())
                              : const Text(
                                  'Generate Dream Movie',
                                  textAlign: TextAlign.center,
                                ),
                        ),
                        onPressed: (screenshotInProgress == true)
                            ? null
                            : () async {
                                WidgetsBinding
                                    .instance.focusManager.primaryFocus
                                    ?.unfocus();
                                final isValid =
                                    formKey.currentState?.validate();

                                if (isValid == true) {
                                  if (image1 != null &&
                                      image2 != null &&
                                      image3 != null &&
                                      image4 != null &&
                                      image5 != null &&
                                      image6 != null &&
                                      image7 != null &&
                                      image8 != null &&
                                      image9 != null &&
                                      image10 != null &&
                                      audio != null &&
                                      caption1Controller.text != '' &&
                                      caption2Controller.text != '' &&
                                      caption3Controller.text != '' &&
                                      caption4Controller.text != '' &&
                                      caption5Controller.text != '' &&
                                      caption6Controller.text != '' &&
                                      caption7Controller.text != '' &&
                                      caption8Controller.text != '' &&
                                      caption9Controller.text != '' &&
                                      caption10Controller.text != '') {
                                    setState(() {
                                      screenshotInProgress = true;
                                    });

                                    await screenshotAndReplace(image1!,
                                        caption1Controller.text.toString());
                                    await screenshotAndReplace(image2!,
                                        caption2Controller.text.toString());
                                    await screenshotAndReplace(image3!,
                                        caption3Controller.text.toString());
                                    await screenshotAndReplace(image4!,
                                        caption4Controller.text.toString());
                                    await screenshotAndReplace(image5!,
                                        caption5Controller.text.toString());
                                    await screenshotAndReplace(image6!,
                                        caption6Controller.text.toString());
                                    await screenshotAndReplace(image7!,
                                        caption7Controller.text.toString());
                                    await screenshotAndReplace(image8!,
                                        caption8Controller.text.toString());
                                    await screenshotAndReplace(image9!,
                                        caption9Controller.text.toString());
                                    await screenshotAndReplace(image10!,
                                        caption10Controller.text.toString());

                                    // File subtitlesFile = await File(
                                    //         folderPath + '/subtitles.srt')
                                    //     .create(recursive: true);
                                    // ;
                                    // String subtitlesContent =
                                    //     '1\n00:00:00,000 --> 00:00:04,000\n${caption1Controller.text.toString()}\n\n2\n00:00:06,000 --> 00:00:09,000\n${caption2Controller.text.toString()}\n\n3\n00:00:11,000 --> 00:00:14,000\n${caption3Controller.text.toString()}\n\n4\n00:00:16,000 --> 00:00:19,000\n${caption4Controller.text.toString()}\n\n5\n00:00:21,000 --> 00:00:24,000\n${caption5Controller.text.toString()}\n\n6\n00:00:26,000 --> 00:00:29,000\n${caption6Controller.text.toString()}\n\n7\n00:00:31,000 --> 00:00:34,000\n${caption7Controller.text.toString()}\n\n8\n00:00:36,000 --> 00:00:39,000\n${caption8Controller.text.toString()}\n\n9\n00:00:41,000 --> 00:00:44,000\n${caption9Controller.text.toString()}\n\n10\n00:00:46,000 --> 00:00:49,000\n${caption10Controller.text.toString()}';
                                    // await subtitlesFile
                                    //     .writeAsString(subtitlesContent);
                                    //
                                    //
                                    //
                                    //s
                                    var a =
                                        await _crudStorage.addDreamMovieData(
                                      user!.uid,
                                      image1!,
                                      image2!,
                                      image3!,
                                      image4!,
                                      image5!,
                                      image6!,
                                      image7!,
                                      image8!,
                                      image9!,
                                      image10!,
                                      caption1Controller.text.toString(),
                                      caption2Controller.text.toString(),
                                      caption3Controller.text.toString(),
                                      caption4Controller.text.toString(),
                                      caption5Controller.text.toString(),
                                      caption6Controller.text.toString(),
                                      caption7Controller.text.toString(),
                                      caption8Controller.text.toString(),
                                      caption9Controller.text.toString(),
                                      caption10Controller.text.toString(),
                                      audio!,
                                      (user?.uid ==
                                              'MsWSztJZpLSQBeRfu0yKWhismu22')
                                          ? 1
                                          : 0,
                                      '', // coupon
                                    );
                                    print(a);
                                    setState(() {
                                      caption1Controller.clear();
                                      caption2Controller.clear();
                                      caption3Controller.clear();
                                      caption4Controller.clear();
                                      caption5Controller.clear();
                                      caption6Controller.clear();
                                      caption7Controller.clear();
                                      caption8Controller.clear();
                                      caption9Controller.clear();
                                      caption10Controller.clear();
                                      image1 = null;
                                      image2 = null;
                                      image3 = null;
                                      image4 = null;
                                      image5 = null;
                                      image6 = null;
                                      image7 = null;
                                      image8 = null;
                                      image9 = null;
                                      image10 = null;
                                      audio = null;
                                      screenshotInProgress = false;
                                    });

                                    Navigator.pop(context);
                                  }
                                } else {
                                  if (image1 == null ||
                                      image2 == null ||
                                      image3 == null ||
                                      image4 == null ||
                                      image5 == null ||
                                      image6 == null ||
                                      image7 == null ||
                                      image8 == null ||
                                      image9 == null ||
                                      image10 == null) {
                                    setState(() {
                                      imagesSelectedError = true;
                                    });
                                  }
                                  if (audio == null) {
                                    setState(() {
                                      audioSelectedError = true;
                                    });
                                  }
                                }
                              }),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  screenshotAndReplace(String filePath, String caption) async {
    print(filePath);
    print(caption);
    await screenshotController
        .captureFromWidget(
      delay: const Duration(seconds: 1),
      Stack(children: <Widget>[
        Image.file(
          File(filePath),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.h),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: <Widget>[
                Text(
                  caption,
                  style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.black,
                  ),
                ),
                Text(caption,
                    style: TextStyle(fontSize: 30, color: Colors.white)),
              ],
            ),
            // child: Text(
            //   caption,
            //   style: const TextStyle(color: white, fontSize: 24),
          ),
        ),
      ]),
    )
        .then((capturedImage) async {
      final image = img.decodeImage(capturedImage);
      if (image != null) {
        final mergedImageBytes = img.encodeJpg(image);
        await File(filePath).writeAsBytes(mergedImageBytes);
        print(filePath);
        print(caption);
        print('donezoo');
      }

      // File file = File(filePath);
      // file.writeAsBytesSync(capturedImage);
    });
  }
}
