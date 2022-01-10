import 'package:flutter/animation.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/services/firebase_service.dart';
import 'package:muhadara/views/login_view.dart';
import 'package:muhadara/views/register_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationViewModel extends FormViewModel {
  final _navService = locator<NavigationService>();
  final _authService = locator<FirebaseService>();
  final _dialogService = locator<DialogService>();

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

  // sign Up
  // obsecured text
  bool isSecured = true;

  void changedObs() {
    isSecured = !isSecured;
    notifyListeners();
  }

  Future signUp({
    required String displayName,
    required String email,
    required String pass,
  }) async {
    setBusy(true);
    var results = await _authService.signUp(
      name: displayName,
      email: email,
      password: pass,
    );
    setBusy(false);
    if (results is bool) {
      if (results) {
        _navService.replaceWith(
          Routes.homeView,
          arguments: HomeViewArguments(userName: _authService.displayName),
        );
      } else {
        _dialogService.showDialog(
          title: 'Authentication Failed',
          description: 'Try again',
        );
      }
    } else {
      _dialogService.showDialog(
        title: 'Authentication Failed',
        description: results,
      );
    }
  }
  Future signIn({
    required String email,
    required String pass,
  }) async {
    setBusy(true);
    var results = await _authService.loginWithEmailAndPassword(
      email: email,
      pass: pass,
    );
    setBusy(false);
    if (results is bool) {
      if (results) {
        _navService.replaceWith(
          Routes.homeView,
          arguments: HomeViewArguments(userName: _authService.displayName),
        );
      } else {
        _dialogService.showDialog(
          title: 'Authentication Failed',
          description: 'Try again',
        );
      }
    } else {
      _dialogService.showDialog(
        title: 'Authentication Failed',
        description: results,
      );
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
