import 'package:flutter/material.dart';

import 'spacers.dart';

class ImageAsset extends StatelessWidget {
  const ImageAsset({super.key, this.imagePath, this.width, this.height, this.color});

  final String? imagePath;
  final BoxFit? boxFit = BoxFit.cover;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return (imagePath != null && imagePath!.isNotEmpty)
        ? Image.asset(imagePath!, fit: boxFit!, width: width, height: height, color: color,)
        : vSpacer0();
  }
}




