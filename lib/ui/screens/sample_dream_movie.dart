import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';

class SampleDreamMovie extends StatefulWidget {
  const SampleDreamMovie({super.key});

  @override
  State<SampleDreamMovie> createState() => _SampleDreamMovieState();
}

class _SampleDreamMovieState extends State<SampleDreamMovie> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool ready = false;

  audioInit() async {
    await audioPlayer.setAsset('assets/dreamMovie/sample.mp3');
    await audioPlayer.setLoopMode(LoopMode.one);
    await audioPlayer.play();
    if (!mounted) return;
    setState(() {
      ready = true;
    });
  }

  @override
  void initState() {
    super.initState();
    audioInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const AppBarEveryWhere(
              title: 'Dream Movie', isIconRequired: true),
          body: (ready == true)
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
                              return Center(
                                child: Image.asset(
                                  'assets/dreamMovie/$i',
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
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
