import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/drawer_view_model.dart';
import 'package:stacked/stacked.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<DrawerViewModel>.nonReactive(
      builder: (BuildContext context, DrawerViewModel model, Widget? child) {
        return Drawer(
          elevation: 0.0,
          child: Container(
            color: primaryColor,
            child: Column(
              children: [
                SizedBox(
                  height: _size.height * 0.3 / 3,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: secColor,
                    size: 30,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      color: secColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const ListTile(
                  leading: Icon(
                    Icons.spa_sharp,
                    color: secColor,
                    size: 30,
                  ),
                  title: Text(
                    'Language',
                    style: TextStyle(
                      color: secColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const ListTile(
                  leading: Icon(
                    Icons.chat_outlined,
                    color: secColor,
                    size: 30,
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: secColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const ListTile(
                  leading: Icon(
                    Icons.ac_unit,
                    color: secColor,
                    size: 30,
                  ),
                  title: Text(
                    'FAQs',
                    style: TextStyle(
                      color: secColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: secColor,
                    size: 30,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      color: secColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => DrawerViewModel(),
    );
  }
}
