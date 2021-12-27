import 'package:muhadara/views/login_view.dart';
import 'package:muhadara/views/register_view.dart';
import 'package:muhadara/views/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: RegisterView),
], dependencies: [
  LazySingleton<NavigationService>(classType: NavigationService),
  LazySingleton<BottomSheetService>(classType: BottomSheetService),
  LazySingleton<SnackbarService>(classType: SnackbarService),
  LazySingleton<DialogService>(classType: DialogService),
])
class App {}
