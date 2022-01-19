import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/library_view_model.dart';
import 'package:stacked/stacked.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<LibraryViewModel>.reactive(
        viewModelBuilder: () => LibraryViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Library',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                model.dataReady
                    ? Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: model.data!.length,
                          shrinkWrap: true,
                          // reverse: true,
                          itemBuilder: (context, index) {
                            final data = model.data![index];

                            return ListTile(
                              leading: data.imagePath == 'Image'
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        'images/noimage.jpg',
                                        width: size.width * 0.2,
                                        height: size.height * 0.2,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Image.file(
                                      File(data.imagePath!),
                                      width: size.width * 0.2,
                                      height: size.height * 0.2,
                                      fit: BoxFit.fill,
                                    ),
                              onTap: () {
                                model.toPlayer(
                                  audioUrl: data.audioPath.toString(),
                                  imageurl: data.imagePath.toString(),
                                  lectureTitle: data.lectureTitle.toString(),
                                  lecturerName: data.lecturerName.toString(),
                                  postedAt: data.savedAt!,
                                  index: 1,
                                );
                              },
                              title: Text(
                                data.lecturerName.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: primaryColor,
                                ),
                              ),
                              subtitle: Text(
                                data.lectureTitle.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: primaryColor,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  model.deleteItem(data.id!);
                                },
                                icon: const Icon(Icons.delete_sharp),
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text(
                          'No Downloads Founds',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      )
              ],
            ),
          );
        });
  }
}
