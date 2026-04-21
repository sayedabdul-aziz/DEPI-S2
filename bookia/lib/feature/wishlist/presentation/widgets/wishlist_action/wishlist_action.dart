import 'package:bookia/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishlistActionWidget extends StatelessWidget {
  const WishlistActionWidget({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: SvgPicture.asset(AppImages.bookmarkSvg),
    );
  }
}
