import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class ImageContainer extends StatelessWidget {
  const ImageContainer({required this.image, super.key});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
