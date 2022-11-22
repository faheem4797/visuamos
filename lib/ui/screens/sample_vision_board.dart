import 'package:flutter/material.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';

class SampleVisionBoard extends StatelessWidget {
  const SampleVisionBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            const AppBarEveryWhere(title: 'Vision Board', isIconRequired: true),
        body: Center(child: Image.asset('assets/visionBoardSample.jpg')),
      ),
    );
  }
}
