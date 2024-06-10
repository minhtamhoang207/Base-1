import 'package:flutter/material.dart';
import 'package:base_1/core/assets_gen/assets.gen.dart';

class ImagePlaceHolder extends StatelessWidget {
  final Size size;
  const ImagePlaceHolder({
    Key? key,
    this.size = const Size(80, 80),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(Assets.images.imagePlaceholder.path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
