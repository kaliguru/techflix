import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/nav_drawer/custom_nav_drawer.dart';
import 'package:play_lab/view/screens/wish_list/widget/wishlist_widget.dart';


import '../../../constants/my_strings.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          drawer: const NavigationDrawerWidget(),
              backgroundColor: MyColor.colorBlack,
              appBar: const CustomAppBar(title: MyStrings.wishList,isShowBackBtn: true,),
              body: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: const [
                    WishlistWidget(),
                  ],
                ),
              ),
            );
  }


}
