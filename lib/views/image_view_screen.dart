// ignore: implementation_imports
import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Stack(
          children: [
            Image.network(imageUrl),
            const BackButton(),
          ],
        )),
      ),
    );
  }
}
