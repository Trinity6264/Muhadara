import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/services/firebase_service.dart';
import 'package:muhadara/services/ob_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final _navSer = locator<NavigationService>();
  final _authService = locator<FirebaseService>();
  final _obService = locator<ObService>();
  void start() => Future.delayed(const Duration(seconds: 3), () async {
        await _obService.initStore();
        var isLoggedIn = await _authService.isLoggedIn();
        return isLoggedIn
            ? _navSer.replaceWith(
                Routes.homeView,
                arguments:
                    HomeViewArguments(userName: _authService.displayName),
              )
            : _navSer.replaceWith(Routes.loginView);
      });
}
