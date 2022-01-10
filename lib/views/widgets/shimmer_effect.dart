import 'package:flutter/material.dart';
import 'package:muhadara/model/user_model.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({Key? key}) : super(key: key);
  static final _data = [
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
    UserModel(id: 'id', userName: 'userName', userEmail: 'images/micky.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      direction: ShimmerDirection.ltr,
      enabled: true,
      child: SizedBox(
        height: _size.height * 0.25,
        child: ListView.builder(
          itemCount: 20,
          key: const PageStorageKey('value1'),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final data = _data[index];
            return Container(
              margin: const EdgeInsets.only(left: 5.0, top: 2.0),
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 200,
                    height: 130.0,
                  ),
                  const SizedBox(height: 5.0),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: 100,
                      height: 10.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: 100,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
