import 'package:flutter/material.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

import '../../../../../core/utils/dimensions.dart';

class PortraitShimmer extends StatelessWidget {
  const PortraitShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 120 for default size of
    return ListView.builder(
      shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white24,
          ),
          width: 105,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const MyShimmerEffectUI.rectangular(width: 105,
                    height: 120,
                  ),
              ),
              const SizedBox(
                height: Dimensions.spaceBetweenTextAndImage,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const MyShimmerEffectUI.rectangular(width: 105,height: 20,),
              )
            ],
          ),
        ));
  }
}
