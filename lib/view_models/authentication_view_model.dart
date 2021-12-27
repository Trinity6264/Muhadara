import 'package:flutter/animation.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/views/login_view.dart';
import 'package:muhadara/views/register_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();

  // navigate to register pov
  void toRegister() {
    _navService.replaceWithTransition(
      RegisterView(),
      curve: Curves.easeInOut,
       duration: const Duration(milliseconds: 300),
      transition: 'rightToLeftWithFade',
    );
  }
  // navigate to register pov
  void toLogin() {
    _navService.replaceWithTransition(
      LoginView(),
      curve: Curves.easeOut,
       duration: const Duration(milliseconds: 300),
      transition: 'leftToRightWithFade',
    );
  }
}
