import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';

import '../../../core/route/route.dart';

class CustomBottomNav extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNav({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavyBar(
      selectedIndex:widget.currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      backgroundColor: MyColor.textFieldColor,
      onItemSelected: (index) {
        _onTap(index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Home'),
          activeColor: MyColor.primaryColor200,
          textAlign: TextAlign.center,
          inactiveColor: Colors.white
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.movie_filter_outlined),
            title: const Text('Movie'),
            activeColor: MyColor.primaryColor,
            textAlign: TextAlign.center,
            inactiveColor: Colors.white
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.movie_filter_rounded),
            title: const Text('Episode'),
            activeColor: MyColor.primaryColor,
            textAlign: TextAlign.center,
            inactiveColor: Colors.white
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.menu),
          title: const Text('Menu'),
            activeColor: MyColor.primaryColor,
            textAlign: TextAlign.center,
            inactiveColor: Colors.white,
        ),
      ],
    );
  }

  void _onTap(int index){
    if(index==0){
      if(!(widget.currentIndex==0)){
        Get.toNamed(RouteHelper.homeScreen);
      }
    }
    else if(index==1){
      if(!(widget.currentIndex==1)){
        Get.toNamed(RouteHelper.allMovieScreen);
      }
    }

    else if(index==2){
      if(!(widget.currentIndex==2)){
        Get.toNamed(RouteHelper.allEpisodeScreen);
      }
    }

    else if(index==3){
      Scaffold.of(context).openDrawer();
    }
  }
}
