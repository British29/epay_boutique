import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderImagePublicite extends StatefulWidget {
  const SliderImagePublicite({Key? key}) : super(key: key);

  @override
  _SliderImagePubliciteState createState() => _SliderImagePubliciteState();
}

class _SliderImagePubliciteState extends State<SliderImagePublicite> {
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.99,
      child: CarouselSlider(
        items: [
          Image.asset('assets/images/img1.jpg'),
          Image.asset('assets/images/img2.jpg'),
        ],
        options: CarouselOptions(
          viewportFraction: 1.0,
          height: MediaQuery.of(context).size.height * 0.7,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 8),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        ),
      ),
    );
  }
}
