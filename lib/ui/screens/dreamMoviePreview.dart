import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:alh_pdf_view/lib.dart';
import 'package:external_path/external_path.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:file_picker/file_picker.dart';
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
import '../colors/colors.dart';

class DreamMoviePreview extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  final String caption1;
  final String caption2;
  final String caption3;
  final String audio;

  const DreamMoviePreview({
    super.key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.caption1,
    required this.caption2,
    required this.caption3,
    required this.audio,
  });

  @override
  State<DreamMoviePreview> createState() => _DreamMoviePreviewState();
}

class _DreamMoviePreviewState extends State<DreamMoviePreview> {
  ScreenshotController screenshotController = ScreenshotController();
  bool? isSaved;
  final pdf = pw.Document();
  String? appDirectory;
  static const String BASE_PATH = '/storage/emulated/0/Download/';

  static const String IMAGE_PATH = BASE_PATH + 'img001.jpg';
  static const String VIDEO_PATH = BASE_PATH + 'Video.mp4';
  static const String GIF_PATH = BASE_PATH + 'giphy.gif';
  static const String AUDIO_PATH = BASE_PATH + 'sample.mp3';
  static const String IMAGE_PATH2 = BASE_PATH + 'img002.jpg';
  static const String IMAGE_PATH3 = BASE_PATH + 'img003.jpg';
  static const String OUTPUT_PATH = BASE_PATH + 'output.mp4';
  static const String IMAGES_PATH = BASE_PATH + 'img%03d.jpg';

  Future<String> addTextToImageAndStoreToTempFiles(
      String image, String caption) async {
    var tempDir = await getTemporaryDirectory();
    Random random = Random();
    print(tempDir);

    var filePath = await screenshotController
        .captureFromWidget(
      delay: const Duration(seconds: 1),
      Stack(children: <Widget>[
        Image.memory(
          base64Decode(image),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              caption,
              style: TextStyle(color: white, fontSize: 24),
            ),
          ),
        ),
      ]),
    )
        .then((capturedImage) async {
      if (image == widget.image1) {
        File file = File(IMAGE_PATH);
        await file.writeAsBytes(capturedImage);
        return file.path;
      } else if (image == widget.image2) {
        File file = File(IMAGE_PATH2);
        await file.writeAsBytes(capturedImage);
        return file.path;
      } else {
        File file = File(IMAGE_PATH3);
        await file.writeAsBytes(capturedImage);
        return file.path;
      }
    });
    return filePath;
  }

  videoMerger() async {
    var tempDir = await getTemporaryDirectory();
    Random random = Random();
    final pathToImage1 =
        await addTextToImageAndStoreToTempFiles(widget.image1, widget.caption1);
    final pathToImage2 =
        await addTextToImageAndStoreToTempFiles(widget.image2, widget.caption2);
    final pathToImage3 =
        await addTextToImageAndStoreToTempFiles(widget.image3, widget.caption3);

    // File textFile = File(
    //     '${tempDir.path}/${(random.nextInt(1000000) + 10).toString()}.txt');
    // File audioFile = File(
    //     '${tempDir.path}/${(random.nextInt(1000000) + 10).toString()}.mp3');
    // await audioFile.writeAsBytes(base64Decode(widget.audio));
    // String textToFile =
    //     "file '${pathToImage1}'\nduration 2\nfile '${pathToImage2}'\nduration 2\nfile '${pathToImage3}'\nduration 2";
    // await textFile.writeAsString(textToFile);
    // print(await textFile.readAsString());

    // String outputPath = tempDir.path + 'out.mp4';

    //
    //
    //
    //
    //
    //
    //
    final FFmpegKit _ffmpegkit = FFmpegKit();

    String commandToExecute =
        '-framerate 1/5 -i ${IMAGES_PATH} -i ${AUDIO_PATH} -c:v libx264 -c:a aac -b:a 192k -shortest ${OUTPUT_PATH}';
// This one does the same as above
    String commandToExecuteNew1 =
        'ffmpeg -framerate 1/5 -i ${IMAGES_PATH} -i ${AUDIO_PATH} -shortest ${OUTPUT_PATH}';
    //This one solves the res issue with images
    String commandFromPC =
        'ffmpeg -framerate 1/5 -i ${IMAGES_PATH} -i ${AUDIO_PATH} -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -shortest ${OUTPUT_PATH}';
    //String commandToExecute = '-framerate 24 -i ${IMAGES_PATH} output.mp4';
    // String commandToExecute =
    //     '-framerate 1/5 -i ${IMAGES_PATH} -i ${AUDIO_PATH} -c:a copy -r 30 -shortest ${OUTPUT_PATH}';
//This one takes all the sequential png images in the directory and merges them and plays audio over it. Each frame is 5 seconds. -shortest isnt working right now
    String commandToExecutefromPC =
        'ffmpeg -framerate 1/5 -i C:\Users\NAC\Desktop\check\img%03d.png -i C:\Users\NAC\Desktop\check\sample.mp3 -c:a copy -r 30 -shortest C:\Users\NAC\Desktop\check\output.mp4';
    //This one plays sequential images over audio
    // String commandToExecute =
    //     '-framerate 20 -i $_directory/image%d.png $_directory/out.mp4';
    // String commandToExecute4 =
    //     '-f concat -i ${textFile.path} -c:v libx264 -r 30 -pix_fmt yuv420p $OUTPUT_PATH';
    String commandToExecutesed =
        '-r 30 -pattern_type sequence -start_number 01 -f image2 -i ${IMAGE_PATH2} -f mp3 -i ${AUDIO_PATH} -y ${OUTPUT_PATH}';
    // String commandToExecuteNew =
    //     '-r 30 -pattern_type sequence -start_number 01 -f image2 -i $pathToImage1 -f mp3 -i ${audioFile.path} -y $outputPath';

    // String commandToExecute1 =
    //     '-r 15 -f concat -i ${textFile.path} -f mp3 -i ${audioFile.path} -c:v libx264 -r 30 -pix_fmt yuv420p -y ${OUTPUT_PATH}';
    String commandExec =
        'ffmpeg -f image2 -i image%3d.jpg -i music.webm output.mp4';
    String commandExe1c =
        'ffmpeg -f image2 -i image%03d.jpg -i music.webm output.mp4';

    String command =
        'ffmpeg -f concat -i input.txt -c:v libx264 -r 30 -pix_fmt yuv420p output.mp4';

    await FFmpegKit.execute(commandToExecute).then((session) async {
      print(await session.getFailStackTrace());
      print(await session.getAllLogsAsString());
      print(await session.getAllStatistics());
      print(await session.getLogsAsString());
      final returnCode = await session.getReturnCode();
      print(returnCode!.getValue());

      print('FFmpeg process exited with rc: ');
      // controller = VideoPlayerController.asset(Constants.OUTPUT_PATH)
      //   ..initialize().then((_) {
      //     notifyListeners();
      //   });
    });
  }

  newMerge() async {
    var tempDir = await getTemporaryDirectory();
    print(tempDir.path);
    File file1 = File(tempDir.path + '/img001.jpg');
    await file1.writeAsBytes(base64Decode(widget.image1));
    print(file1.path);
    File file2 = File(tempDir.path + '/img002.jpg');
    await file2.writeAsBytes(base64Decode(widget.image2));
    print(file2.path);
    File file3 = File(tempDir.path + '/img003.jpg');
    await file3.writeAsBytes(base64Decode(widget.image3));
    print(file3.path);
    File file4 = File(tempDir.path + '/audio.mp3');
    await file4.writeAsBytes(base64Decode(widget.audio));
    print(file4.path);

    await Future.delayed(Duration(seconds: 1));
    String commandToExecute =
        '-r 30 -f image2 -i /data/user/0/com.garza.visuamos/cache/img%03d.jpg -f mp3 -i ${file4.path} -y ${OUTPUT_PATH}';
    String abc = '-r 15 -f image2 -i ${file1.path} -y ${OUTPUT_PATH}';
    //This one does the jon
    String commandFromPC =
        '-framerate 1/5 -i /data/user/0/com.garza.visuamos/cache/img%03d.jpg -i ${file4.path} -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -shortest ${OUTPUT_PATH}';

    FFmpegKit.executeAsync(commandFromPC, (session) async {
      final state =
          FFmpegKitConfig.sessionStateToString(await session.getState());
      final returnCode = await session.getReturnCode();
      final failStackTrace = await session.getFailStackTrace();
      final duration = await session.getDuration();

      if (ReturnCode.isSuccess(returnCode)) {
        print(
            "Encode completed successfully in ${duration} milliseconds; playing video.");
        setState(() {
          isSaved = true;
        });
      } else {
        print("Encode failed. Please check log for the details.");
        print(
            "Encode failed with state ${state} and rc ${returnCode}.${(failStackTrace)}");
      }
    }, (log) => print(log.getMessage()), (statistics) {})
        .then((session) => print(
            "Async FFmpeg process started with sessionId ${session.getSessionId()}."));
  }

  @override
  void initState() {
    super.initState();
    newMerge();
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
        body: (isSaved == true)
            ? Column(
                children: [
                  Expanded(
                    child: Text('Video saved to Download Directory'),
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
                              // await ImageGallerySaver.saveImage(
                              //     capturedScreenshotImage!,
                              //     name: widget.fileName);
                              //
                              //
                              //
                              // if (await requestPermission(Permission.storage)) {
                              //   await GallerySaver.saveImage(appDirectory!);
                              // } else {
                              //   print('permission for storage');
                              //   print(await Permission.storage.isGranted);
                              //   await Permission.storage.request();
                              // }
                            },
                            child: Text(
                              'Save Video',
                              textAlign: TextAlign.center,
                            )),
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
