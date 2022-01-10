import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/home_sub_view_model.dart';
import 'package:muhadara/views/widgets/shimmer_effect.dart';
import 'package:stacked/stacked.dart';

class RecommendedView extends StatelessWidget {
  const RecommendedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeSubViewModel>.reactive(
      onModelReady: (model) => model.fecthAll(0),
      fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      builder:(BuildContext contxt, HomeSubViewModel model, Widget? child) {
        Size _size = MediaQuery.of(context).size;
        return model.isBusy
            ? const ShimmerEffect()
            : model.recommendedData!.isEmpty
                ? const SizedBox.shrink()
                : SizedBox(
                    height: _size.height * 0.25,
                    child: ListView.builder(
                      itemCount: model.recommendedData?.length,
                      key: const PageStorageKey('value2'),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final data = model.recommendedData![index];
                        return GestureDetector(
                          onTap: () {
                            model.toPlayer(data,);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5.0, top: 2.0),
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    data.imageurl.toString(),
                                    fit: BoxFit.cover,
                                    height: 130.0,
                                    width: 200,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    data.lecturerName.toString(),
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    data.lectureTitle.toString(),
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
      },
      viewModelBuilder: () => HomeSubViewModel(),
    );
  }
}
