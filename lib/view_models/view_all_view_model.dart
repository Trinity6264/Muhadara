import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewAllViewModel extends BaseViewModel {
  final _snackService = locator<SnackbarService>();

  void downLoad() {
    _snackService.registerSnackbarConfig(SnackbarConfig(
      messageColor: secColor,
    ));
    _snackService.showSnackbar(message: 'Not Available at now');
  }
}
