import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/shared/input_deco.dart';
import 'package:muhadara/view_models/lecture_view_model.dart';
import 'package:muhadara/views/widgets/lecture_view.form.dart';
import 'package:muhadara/views/widgets/percentage_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'lecturer'),
  FormTextField(name: 'lecture'),
])
class LectureView extends StatelessWidget with $LectureView {
  LectureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LectureViewModel>.reactive(
      viewModelBuilder: () => LectureViewModel(),
      builder: (context, model, child) {
        Size size = MediaQuery.of(context).size;
        return SingleChildScrollView(
          key: const PageStorageKey('lecture'),
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Upload your Lecture',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => model.getImage(),
                  child: Container(
                    height: size.height * 0.3 / 1.3,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: model.imageSelect != null
                        ? Image.file(model.imageSelect!, fit: BoxFit.cover)
                        : const Center(
                            child: Text(
                            'Click Here to Upload Artwork',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: primaryColor,
                            ),
                          )),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 3.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lecturer Name',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: inputDecoration,
                      controller: lecturerController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Lecture Name',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: inputDecoration,
                      controller: lectureController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: model.audioSelect != null
                              ? darkColor
                              : primaryColor,
                        ),
                        onPressed: () => model.getAudio(),
                        child: const Text('Click Here to Upload Lecture'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    model.isBusy
                        ?  Center(
                            child: Column(
                              children: [
                                const CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                                const SizedBox(height: 20),
                                model.task != null? buildUploadStatus(model.task!):const SizedBox.shrink(),
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                              ),
                              onPressed: () => model.uploadContent(lectureController.text, lecturerController.text).then((value) {
                                lectureController.clear();
                                lecturerController.clear();
                              }),
                              child: const Text('Upload'),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
