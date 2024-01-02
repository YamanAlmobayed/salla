import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla/repository/models/home_model.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key, required this.banners});

  final List<BannerModel> banners;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: banners
          .map((e) => Image(
                image: CachedNetworkImageProvider('${e.image}'),
                fit: BoxFit.cover,
                width: double.maxFinite,
              ))
          .toList(),
      options: CarouselOptions(
        height: 400.0.w,
        initialPage: 0,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
