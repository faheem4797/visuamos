import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:visuamos/ui/utils.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import '../colors/colors.dart';

class DreamMoviePreview extends StatefulWidget {
  final String folderName;

  //final String audio;

  const DreamMoviePreview({super.key, required this.folderName});

  @override
  State<DreamMoviePreview> createState() => _DreamMoviePreviewState();
}

class _DreamMoviePreviewState extends State<DreamMoviePreview> {
  ScreenshotController screenshotController = ScreenshotController();
  bool videoReady = false;
  String? outputVideoFilePath;
  AudioPlayer audioPlayer = AudioPlayer();
  static const String BASE_PATH = '/storage/emulated/0/Download/';
  // late VideoPlayerController videoPlayerController;
  // ChewieController? chewieController;

  // static const String IMAGE_PATH = BASE_PATH + 'img001.jpg';
  // static const String VIDEO_PATH = BASE_PATH + 'Video.mp4';
  // static const String GIF_PATH = BASE_PATH + 'giphy.gif';
  // static const String AUDIO_PATH = BASE_PATH + 'sample.mp3';
  // static const String IMAGE_PATH2 = BASE_PATH + 'img002.jpg';
  // static const String IMAGE_PATH3 = BASE_PATH + 'img003.jpg';
  // static const String IMAGES_PATH = BASE_PATH + 'img%03d.jpg';

  // Future<String> addTextToImageAndStoreToTempFiles(
  //     String image, String caption) async {
  //   var tempDir = await getTemporaryDirectory();
  //   Random random = Random();
  //   print(tempDir);

  //   var filePath = await screenshotController
  //       .captureFromWidget(
  //     delay: const Duration(seconds: 1),
  //     Stack(children: <Widget>[
  //       Image.memory(
  //         base64Decode(image),
  //         fit: BoxFit.fill,
  //         height: double.infinity,
  //         width: double.infinity,
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(bottom: 30.h),
  //         child: Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Text(
  //             caption,
  //             style: const TextStyle(color: white, fontSize: 24),
  //           ),
  //         ),
  //       ),
  //     ]),
  //   )
  //       .then((capturedImage) async {
  //     if (image == widget.image1) {
  //       File file = File(tempDir.path + '/img001.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image2) {
  //       File file = File(tempDir.path + '/img002.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image3) {
  //       File file = File(tempDir.path + '/img003.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image4) {
  //       File file = File(tempDir.path + '/img004.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image5) {
  //       File file = File(tempDir.path + '/img005.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image6) {
  //       File file = File(tempDir.path + '/img006.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image7) {
  //       File file = File(tempDir.path + '/img007.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image8) {
  //       File file = File(tempDir.path + '/img008.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else if (image == widget.image9) {
  //       File file = File(tempDir.path + '/img009.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     } else {
  //       File file = File(tempDir.path + '/img010.jpg');
  //       await file.writeAsBytes(capturedImage);
  //       return file.path;
  //     }
  //   });
  //   return filePath;
  // }

  videoMerger() async {
    var tempDir = await getTemporaryDirectory();
    Random random = Random();
    String outputPath =
        '$BASE_PATH${random.nextInt(900000) + 100000}output.mp4';
    String tempOutputPath =
        '${tempDir.path}${random.nextInt(900000) + 100000}output.mp4';
    //'${tempDir.path}/${random.nextInt(900000) + 100000}output.mp4';

    // final pathToImage1 =
    //     '/data/user/0/com.garza.visuamos/app_flutter/631219/img001.jpg';
    // final pathToImage2 =
    //     '/data/user/0/com.garza.visuamos/app_flutter/631219/img002.jpg';
    // final pathToImage3 =
    //     '/data/user/0/com.garza.visuamos/app_flutter/631219/img003.jpg';
    // final audioFile =
    //     '/data/user/0/com.garza.visuamos/app_flutter/631219/audio.mp3';
    // final pathToImage1 =
    //     await addTextToImageAndStoreToTempFiles(widget.image1, widget.caption1);
    // final pathToImage2 =
    //     await addTextToImageAndStoreToTempFiles(widget.image2, widget.caption2);
    // final pathToImage3 =
    //     await addTextToImageAndStoreToTempFiles(widget.image3, widget.caption3);
    // final pathToImage4 =
    //     await addTextToImageAndStoreToTempFiles(widget.image4, widget.caption4);
    // final pathToImage5 =
    //     await addTextToImageAndStoreToTempFiles(widget.image5, widget.caption5);
    // final pathToImage6 =
    //     await addTextToImageAndStoreToTempFiles(widget.image6, widget.caption6);
    // final pathToImage7 =
    //     await addTextToImageAndStoreToTempFiles(widget.image7, widget.caption7);
    // final pathToImage8 =
    //     await addTextToImageAndStoreToTempFiles(widget.image8, widget.caption8);
    // final pathToImage9 =
    //     await addTextToImageAndStoreToTempFiles(widget.image9, widget.caption9);
    // final pathToImage10 = await addTextToImageAndStoreToTempFiles(
    //     widget.image10, widget.caption10);
    // File audioFile = File(tempDir.path + '/audio.mp3');
    // await audioFile.writeAsBytes(base64Decode(widget.audio));

    //This one does the job

    // String commandFromPC =
    //     '-framerate 1/5 -i /data/user/0/com.garza.visuamos/app_flutter/817624/img%03d.jpg -i /data/user/0/com.garza.visuamos/app_flutter/817624/audio.mp3 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -pix_fmt yuv420p $OUTPUT_PATH';

    String commandFromPC =
        '-framerate 1/5 -i ${widget.folderName}img%03d.jpg -i ${widget.folderName}audio.mp3 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -pix_fmt yuv420p $tempOutputPath';
    String commandForSubtitles =
        '-y -i $tempOutputPath -vf "subtitles=${widget.folderName}subtitles.srt" -c:v libx264 -pix_fmt yuv420p $outputPath';
//ffmpeg -i video.avi -vf subtitles=subtitle.srt out.avi
    print('before 1st session');
    await FFmpegKit.executeAsync(commandFromPC, (session) async {
      final state =
          FFmpegKitConfig.sessionStateToString(await session.getState());
      final returnCode = await session.getReturnCode();
      final failStackTrace = await session.getFailStackTrace();
      final duration = await session.getDuration();

      if (ReturnCode.isSuccess(returnCode)) {
        print(
            "Encode completed successfully in ${duration} milliseconds; playing video.");

        setState(() {
          outputVideoFilePath = tempOutputPath;
          videoReady = true;
        });

        await audioPlayer.setFilePath(// Load a URL
            '${widget.folderName}audio.mp3');
        // Schemes: (https: | file: | asset: )
        await audioPlayer.setLoopMode(LoopMode.one);
        await audioPlayer.play();
        //_initPlayer(outputVideoFilePath!);

        // await FFmpegKit.executeAsync(commandForSubtitles, (session) async {
        //   final state =
        //       FFmpegKitConfig.sessionStateToString(await session.getState());
        //   final returnCode = await session.getReturnCode();
        //   final failStackTrace = await session.getFailStackTrace();
        //   final duration = await session.getDuration();

        //   if (ReturnCode.isSuccess(returnCode)) {
        //     print(
        //         "Encode completed successfully in ${duration} milliseconds; playing video.");
        //     print('after 2nd session');
        //     setState(() {
        //       isSaved = true;
        //     });
        //   } else {
        //     print("Encode failed. Please check log for the details.");
        //     print(
        //         "Encode failed with state ${state} and rc ${returnCode}.${(failStackTrace)}");
        //   }
        // }, (log) => print(log.getMessage()), (statistics) {})
        //     .then((session) => print(
        //         "Async FFmpeg process started with sessionId ${session.getSessionId()}."));
      } else {
        print("Encode failed. Please check log for the details.");
        print(
            "Encode failed with state ${state} and rc ${returnCode}.${(failStackTrace)}");
      }
    }, (log) => print(log.getMessage()), (statistics) {})
        .then((session) => print(
            "Async FFmpeg process started with sessionId ${session.getSessionId()}."));
  }

  // void _initPlayer(String filePath) async {
  //   videoPlayerController = VideoPlayerController.file(File(filePath));
  //   await videoPlayerController.initialize();
  //   chewieController = ChewieController(
  //       videoPlayerController: videoPlayerController,
  //       autoPlay: true,
  //       looping: true);
  // }

  @override
  void initState() {
    super.initState();
    videoMerger();
  }

  @override
  void dispose() {
    // videoPlayerController.dispose();
    // chewieController?.dispose();
    audioPlayer.dispose();
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
        body: (videoReady == true)
            ? Column(
                children: [
                  //Expanded(
                  //child:
                  //Chewie(controller: chewieController!),
                  //),
                  const SizedBox(height: 10),

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final double height =
                            MediaQuery.of(context).size.height;
                        return CarouselSlider(
                          //carouselController: ,
                          options: CarouselOptions(
                              height: height,
                              enableInfiniteScroll: true,
                              viewportFraction: 1.0,
                              initialPage: 0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  const Duration(microseconds: 5),
                              pauseAutoPlayOnTouch: false,
                              autoPlayCurve: Curves.linear,
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              //scrollDirection: Axis.vertical,

                              onPageChanged: (index, reason) async {}),
                          items: [
                            'img001.jpg',
                            'img002.jpg',
                            'img003.jpg',
                            'img004.jpg',
                            'img005.jpg',
                            'img006.jpg',
                            'img007.jpg',
                            'img008.jpg',
                            'img009.jpg',
                            'img010.jpg'
                          ].map((i) {
                            print(widget.folderName + i);
                            return Center(
                              child: Image.file(
                                File(widget.folderName + i),
                                height: double.maxFinite,
                                // height: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        );
                      },
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
                                backgroundColor: purplePopupButton,
                                textStyle: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              if (await requestPermission(Permission.storage)) {
                                await ImageGallerySaver.saveFile(
                                    outputVideoFilePath!);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Video has been successfully saved to gallery')));
                                print('Video Saved');
                              } else {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Permission not granted')));
                                print('permission not granted');
                              }
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
