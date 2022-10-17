import 'dart:io';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/balanceSlipWidget.dart';
import 'package:visuamos/ui/widgets/bankStatementWidget.dart';
import 'package:visuamos/ui/widgets/commonBottomButton.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:alh_pdf_view/lib.dart';
import 'package:visuamos/ui/widgets/dreamCheckWidget.dart';
import '../colors/colors.dart';

class SimpleImagePreview extends StatefulWidget {
  final String date;
  final String amount;
  final int imageType;
  final String fileName;
  final String name;
  const SimpleImagePreview(
      {super.key,
      required this.fileName,
      required this.date,
      required this.amount,
      required this.imageType,
      required this.name});

  @override
  State<SimpleImagePreview> createState() => _SimpleImagePreviewState();
}

class _SimpleImagePreviewState extends State<SimpleImagePreview> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? capturedScreenshotImage;
  Uint8List? pdfDoc;
  final pdf = pw.Document();
  String? appDirectory;

  Future<String> dateSplit(String date) async {
    List<String> splitList = (date).split("-");
    String midSplitMonth = (int.parse(splitList[1]) - 1).toString();
    splitList[1] = midSplitMonth;
    String joinedDate = splitList.join('-');
    //return joinedDate;
    return joinedDate;
  }

  saveAsPdf() async {
    if (Platform.isAndroid) {
      if (await requestPermission(Permission.storage)) {
        var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOCUMENTS);
      }
    }
  }

  Future<void> convertToPdfAndSave() async {
    if (capturedScreenshotImage != null) {
      print('screenshot not null');
      if (Platform.isAndroid) {
        print('android');
        if (await requestPermission(Permission.storage)) {
          var path = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOCUMENTS);
          File filePdf = File('${path}/${widget.fileName}.pdf');
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
        } else {
          var path = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOCUMENTS);
          File filePdf = File('${path}/${widget.fileName}.pdf');
          print(filePdf.path);
          print(await filePdf.exists());
          final image = pw.MemoryImage(capturedScreenshotImage!);
          pdf.addPage(pw.Page(
              pageFormat: PdfPageFormat.letter,
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Image(image),
                ); // Center
              }));
          await filePdf.writeAsBytes(await pdf.save());
          print(filePdf.path);
          print(await filePdf.exists());
        }
      }
    } else {
      print('capturedScreenshotImage is null');
    }
  }

  void saveAsImage() async {}

  void captureScreenshotAndConvertToPDF() async {
    await screenshotController
        .captureFromWidget(
      delay: const Duration(seconds: 1),
      Material(
          //textStyle: TextStyle(fontFamily: 'Merriweather'),
          child: (widget.imageType == 0)
              ? BalanceSlipWidget(date: widget.date, amount: widget.amount)
              : (widget.imageType == 1)
                  ? BankStatementWidget(
                      date: widget.date,
                      prevDate: await dateSplit(widget.date),
                      amount: widget.amount,
                      name: widget.name)
                  : DreamCheckWidget(
                      date: widget.date,
                      amount: widget.amount,
                      name: widget.name)),
    )
        .then((capturedImage) async {
      final tempDirectory = await getTemporaryDirectory();
      File file = File('${tempDirectory.path}/${widget.fileName}.jpg');
      print(file.path);

      setState(() {
        capturedScreenshotImage = capturedImage;
        appDirectory = file.path;
      });
      print(appDirectory);
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
                              await ImageGallerySaver.saveImage(
                                  capturedScreenshotImage!,
                                  name: widget.fileName);
                              // if (await requestPermission(Permission.storage)) {
                              //   await GallerySaver.saveImage(appDirectory!);
                              // } else {
                              //   print('permission for storage');
                              //   print(await Permission.storage.isGranted);
                              //   await Permission.storage.request();
                              // }
                            },
                            child: Text(
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
                              if (await Permission.storage
                                  .request()
                                  .isGranted) {
                                print('inside');
                                await convertToPdfAndSave();
                                // Either the permission was already granted before or the user just granted it.
                              } else {
                                print('outside');
                                await convertToPdfAndSave();
                              }
                            },
                            child: Center(
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

  AlhPdfView newMethodalhpdf() {
    return AlhPdfView(
      bytes: pdfDoc,
      defaultZoomFactor: 1.3,
      minZoom: 1.0,
      fitPolicy: FitPolicy.width,
      fitEachPage: false,
      pageSnap: false,
      onError: (error) {
        print(error.toString());
      },
      onPageError: (page, error) {
        print('$page: ${error.toString()}');
      },
    );
  }
}
