import 'package:muhadara/services/cloud_storage_service.dart';
import 'package:muhadara/services/cloud_store_service.dart';
import 'package:muhadara/services/file_download_service.dart';
import 'package:muhadara/services/file_selected_service.dart';
import 'package:muhadara/services/firebase_service.dart';
import 'package:muhadara/services/ob_service.dart';
import 'package:muhadara/views/audio_player_view.dart';
import 'package:muhadara/views/home/view_all/view_all_view.dart';
import 'package:muhadara/views/home_view.dart';
import 'package:muhadara/views/login_view.dart';
import 'package:muhadara/views/register_view.dart';
import 'package:muhadara/views/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: AudioPlayerView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: RegisterView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: ViewAllView),
],
// registering service
    dependencies: [
      //  Stacked services
      LazySingleton<NavigationService>(classType: NavigationService),
      LazySingleton<BottomSheetService>(classType: BottomSheetService),
      LazySingleton<SnackbarService>(classType: SnackbarService),
      LazySingleton<DialogService>(classType: DialogService),

      // Custom Services
      LazySingleton<FirebaseService>(classType: FirebaseService),
      LazySingleton<CloudStorageService>(classType: CloudStorageService),
      LazySingleton<FileSelectService>(classType: FileSelectService),
      LazySingleton<CloudStoreService>(classType: CloudStoreService),
      LazySingleton<ObService>(classType: ObService),
      LazySingleton<FileDownloadService>(classType: FileDownloadService),
    ])
class App {}
