import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit()..loadInitData(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: WishlistScreen(),
    ),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: CustomSvgPicture(path: AppImages.homeSvg),
            activeIcon: CustomSvgPicture(
              path: AppImages.homeSvg,
              color: AppColors.primaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgPicture(path: AppImages.bookmarkSvg),
            activeIcon: CustomSvgPicture(
              path: AppImages.bookmarkSvg,
              color: AppColors.primaryColor,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgPicture(path: AppImages.cartSvg),
            activeIcon: CustomSvgPicture(
              path: AppImages.cartSvg,
              color: AppColors.primaryColor,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgPicture(path: AppImages.profileSvg),
            activeIcon: CustomSvgPicture(
              path: AppImages.profileSvg,
              color: AppColors.primaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
