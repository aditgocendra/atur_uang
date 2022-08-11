import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  final heightContainer;
  BannerImage({Key? key, required this.heightContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightContainer,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/banner/banner_1.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: const Color.fromARGB(255, 205, 205, 205),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

// constraints.maxWidth / 3 + 30