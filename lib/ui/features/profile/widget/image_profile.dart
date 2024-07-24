
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

import '../../../../utils/colors.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile(
    {
      super.key,
      this.image,
      this.radiusImage,
      this.radiusButton,
      this.onpressed,
      
    }
    );
  final String? image;
  final double? radiusImage;
  final double? radiusButton;
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          radius: radiusImage,
          backgroundImage:image!=null?NetworkImage(image!):null,
          child: image==null?const Icon(CupertinoIcons.person,size: 55,color: cBlack,):null,
        ),
        Positioned(
          bottom: 3,
          right: 8,
          child: CircleAvatar(
            radius: radiusButton,
            backgroundColor: Colors.grey.shade100,
            child: IconButton(icon: const Icon(Icons.add_a_photo_outlined,color:cBlack),onPressed:onpressed ,),
          ),
        )
      ],
    );
  }
}