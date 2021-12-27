import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/start_view_model.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.nonReactive(
      onModelReady: (model)=> model.start(),
      viewModelBuilder: () => StartUpViewModel(),
      builder: (context, model, child) => const Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Text(
            'MUHADARA',
            style: TextStyle(
              color: secColor,
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}
