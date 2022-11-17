import 'dart:io';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/balanceSlipWidget.dart';
import 'package:visuamos/ui/widgets/bankStatementWidget.dart';
import 'package:visuamos/ui/widgets/commonBottomButton.dart';
import 'package:visuamos/ui/widgets/dreamCheckWidget.dart';
import 'package:visuamos/ui/widgets/visionBoardWidget.dart';

import '../colors/colors.dart';

class VisionBoardPreview extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  final String fileName;

  const VisionBoardPreview({
    super.key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.image6,
    required this.image7,
    required this.image8,
    required this.fileName,
  });

  @override
  State<VisionBoardPreview> createState() => _VisionBoardPreviewState();
}

class _VisionBoardPreviewState extends State<VisionBoardPreview> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? capturedScreenshotImage;
  Uint8List? pdfDoc;
  final pdf = pw.Document();

  saveToStorage(File filePdf) async {
    if (await requestPermission(Permission.storage)) {
      print(filePdf.path);
      print(filePdf.exists());

      final image = pw.MemoryImage(capturedScreenshotImage!);
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.letter,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            ); // Center
          }));
      await filePdf.writeAsBytes(await pdf.save());

      final pdfDocInBytes = await pdf.save();
      setState(() {
        pdfDoc = pdfDocInBytes;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Vision Board has been successfully saved as pdf in the External Documents directory')));
      print(
          'Vision Board has been successfully saved as pdf in the documents directory');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission not granted')));
      print('permission not granted');
    }
  }

  Future<void> convertToPdfAndSave() async {
    if (capturedScreenshotImage != null) {
      print('screenshot not null');
      if (Platform.isAndroid) {
        var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOCUMENTS);
        File filePdfAndroid = File('$path/${widget.fileName}.pdf');
        await saveToStorage(filePdfAndroid);
      }
      //FOR IOS
      else {
        var appDocDir = await getApplicationDocumentsDirectory();
        var path = appDocDir.path;
        File filePdfIOS = File('$path/${widget.fileName}.pdf');
        await saveToStorage(filePdfIOS);
      }
    } else {
      print('capturedScreenshotImage is null');
    }
  }

  void captureScreenshotAndConvertToPDF() async {
    await screenshotController
        .captureFromWidget(
      delay: const Duration(seconds: 1),
      Material(
          //textStyle: TextStyle(fontFamily: 'Merriweather'),
          child: VisionBoardWidget(
        image1: widget.image1,
        image2: widget.image2,
        image3: widget.image3,
        image4: widget.image4,
        image5: widget.image5,
        image6: widget.image6,
        image7: widget.image7,
        image8: widget.image8,
      )),
    )
        .then((capturedImage) async {
      // final tempDirectory = await getTemporaryDirectory();
      // File file = File('${tempDirectory.path}/${widget.fileName}.jpg');
      // print(file.path);

      setState(() {
        capturedScreenshotImage = capturedImage;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    captureScreenshotAndConvertToPDF();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarEveryWhere(
          title: 'Vision Board',
          isIconRequired: true,
          callBackFunc: () {
            logoutAndPushLoginScreen(context);
          },
        ),
        body: (capturedScreenshotImage != null)
            ? Column(
                children: [
                  Expanded(
                    child: Image.memory(
                      capturedScreenshotImage!,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 70.h,
                        width: 165.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                primary: black,
                                textStyle: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              if (await requestPermission(Permission.storage)) {
                                await ImageGallerySaver.saveImage(
                                    capturedScreenshotImage!,
                                    name: widget.fileName);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Vision Board has been successfully saved to gallery')));
                                print('Vision Board Saved');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Permission not granted')));
                                print('permission not granted');
                              }
                            },
                            child: const Text(
                              'Save as Image',
                              textAlign: TextAlign.center,
                            )),
                      ),
                      SizedBox(
                        height: 70.h,
                        width: 165.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                primary: black,
                                textStyle: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              await convertToPdfAndSave();
                            },
                            child: const Center(
                                child: Text(
                              'Save as PDF',
                              textAlign: TextAlign.center,
                            ))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
