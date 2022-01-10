import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/home_sub_view_model.dart';
import 'package:muhadara/views/home/new_release/new_release_view.dart';
import 'package:muhadara/views/home/recommended/recommended_view.dart';
import 'package:muhadara/views/home/trending/trending_view.dart';
import 'package:stacked/stacked.dart';

class HomeSubView extends StatelessWidget {
  const HomeSubView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeSubViewModel>.reactive(
      viewModelBuilder: () => HomeSubViewModel(),
      onModelReady: (model) {
        model.fecthAll(0);
      },
      builder: (context, model, child) {
        return SingleChildScrollView(
          key: const PageStorageKey('allinOne'),
          child: Column(
            children: [
              headingsForHome('Recommended', context, 0, model),
              const RecommendedView(),
              headingsForHome('Trending', context, 1, model),
              const TrendingView(),
              headingsForHome('New Release', context, 2, model),
              const NewReleaseView(),
            ],
          ),
        );
      },
    );
  }

  Padding headingsForHome(
      String leftText, BuildContext context, int id, HomeSubViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: const TextStyle(
                color: primaryColor, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  elevation: 0.0,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  model.toAllViews(0);
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: primaryColor,
                size: 15.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
