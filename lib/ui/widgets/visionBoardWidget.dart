import 'dart:io';

import 'package:flutter/material.dart';

class VisionBoardWidget extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;

  const VisionBoardWidget({
    super.key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.image6,
    required this.image7,
    required this.image8,
  });

  @override
  State<VisionBoardWidget> createState() => _VisionBoardWidgetState();
}

class _VisionBoardWidgetState extends State<VisionBoardWidget> {
  List<String> imagesList = [];
  @override
  void initState() {
    imagesList.add(widget.image1);
    imagesList.add(widget.image2);
    imagesList.add(widget.image3);
    imagesList.add(widget.image4);
    imagesList.add(widget.image5);
    imagesList.add(widget.image6);
    imagesList.add(widget.image7);
    imagesList.add(widget.image8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                children: imagesList.map((photo) {
                  return Image.file(
                    File(photo),
                    fit: BoxFit.scaleDown,
                  );
                }).toList(),
              ),
            ),
          ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Image.memory(
          //         base64Decode(widget.image1),
          //         fit: BoxFit.scaleDown,
          //       ),
          //       Image.memory(
          //         base64Decode(widget.image2),
          //         fit: BoxFit.scaleDown,
          //       ),
          //     ],
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Image.memory(
          //       base64Decode(widget.image3),
          //       fit: BoxFit.scaleDown,
          //     ),
          //     Image.memory(
          //       base64Decode(widget.image4),
          //       fit: BoxFit.scaleDown,
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Image.memory(
          //       base64Decode(widget.image5),
          //       fit: BoxFit.scaleDown,
          //     ),
          //     Image.memory(
          //       base64Decode(widget.image6),
          //       fit: BoxFit.scaleDown,
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Image.memory(
          //       base64Decode(widget.image7),
          //       fit: BoxFit.scaleDown,
          //     ),
          //     Image.memory(
          //       base64Decode(widget.image8),
          //       fit: BoxFit.scaleDown,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
