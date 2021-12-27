import 'package:flutter/material.dart';
import 'package:muhadara/app/app.locator.dart';
import 'package:muhadara/app/app.router.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muhadara',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: primaryColor),
        primarySwatch: Colors.green,
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: primaryColor)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryColor,
          elevation: 10,
          selectedLabelStyle: TextStyle(
              color: secColor, fontFamily: 'Montserrat', fontSize: 14.0),
          unselectedLabelStyle: TextStyle(
              color: colorGrey, fontFamily: 'Montserrat', fontSize: 12.0),
          selectedItemColor: secColor,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: true,
        ),
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
