import 'package:flutter/material.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';

class SampleSimpleImage extends StatelessWidget {
  final int imageType;
  const SampleSimpleImage({super.key, required this.imageType});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarEveryWhere(
            title: (imageType == 0)
                ? 'Balance Slips'
                : (imageType == 1)
                    ? 'Bank Statements'
                    : 'Dream Checks',
            isIconRequired: true),
        body: (imageType == 0)
            ? Center(child: Image.asset('assets/sample0.jpg'))
            : (imageType == 1)
                ? Center(child: Image.asset('assets/sample1.jpg'))
                : Center(child: Image.asset('assets/sample2.jpg')),
      ),
    );
  }
}
