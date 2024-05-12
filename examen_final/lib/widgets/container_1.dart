import 'package:flutter/material.dart';

class Container1 extends StatefulWidget {
  const Container1({
    Key? key,
  }) : super(key: key);

  @override
  _ContainerUnoState createState() => _ContainerUnoState();
}

class _ContainerUnoState extends State<Container1> {
  bool isImageChanged = false;

  void changeImage() {
    setState(() {
      isImageChanged = !isImageChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = isImageChanged
        ? 'https://www.shutterstock.com/shutterstock/photos/1814638229/display_1500/stock-vector-super-oferta-spanish-translation-for-great-offer-1814638229.jpg'
        : 'https://media.spdigital.cl/file_upload/Desktop_Hero_LG_27aa6337.webp';

    return GestureDetector(
      onTap: changeImage,
      child: Image.network(imageUrl),
    );
  }
}
