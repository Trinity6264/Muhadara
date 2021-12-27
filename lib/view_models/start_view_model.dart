import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final _navSer = locator<NavigationService>();
  void start() => Future.delayed(
      const Duration(seconds: 3),
      ()=> _navSer.replaceWith(Routes.loginView)
    );
}
