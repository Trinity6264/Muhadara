import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muhadara/views/widgets/drawer_view.dart';
import 'package:muhadara/views/widgets/home_sub_view.dart';
import 'package:muhadara/views/widgets/lecture_view.dart';
import 'package:muhadara/views/widgets/library_view.dart';
import 'package:muhadara/views/widgets/search_view.dart';
import 'package:stacked/stacked.dart';

import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/home_view_model.dart';

class HomeView extends StatelessWidget {
  final String? userName;
  const HomeView({
    Key? key,
    required this.userName,
  }) : super(key: key);

  static const _navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Lecture'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(
        icon: Icon(Icons.my_library_music_rounded), label: 'Library')
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (BuildContext context, HomeViewModel model, Widget? child) {
        return Scaffold(
          drawerScrimColor: primaryColor.withOpacity(.3),
          drawerDragStartBehavior: DragStartBehavior.down,
          backgroundColor: secColor,
          drawer: const DrawerView(),
          appBar: AppBar(
            backgroundColor: secColor,
            elevation: 0.0,
            title: Text(
              userName ?? 'Home',
              style: const TextStyle(
                color: primaryColor,
              ),
            ),
          ),
          body: PageTransitionSwitcher(
              reverse: model.reverse,
              duration: const Duration(milliseconds: 900),
              transitionBuilder: (
                Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: getViewFormIndex(model.currentIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: _navBarItems,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
          ),
        );
      },
    );
  }

  Widget? getViewFormIndex(int index) {
    switch (index) {
      case 0:
        return const  HomeSubView();

      case 1:
        return  LectureView();

      case 2:
        return  SearchView();

      case 3:
        return const LibraryView();

      default:
        return const HomeSubView();
    }
  }
}
