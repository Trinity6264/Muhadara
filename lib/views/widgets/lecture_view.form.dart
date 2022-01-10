// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String LecturerValueKey = 'lecturer';
const String LectureValueKey = 'lecture';

mixin $LectureView on StatelessWidget {
  final TextEditingController lecturerController = TextEditingController();
  final TextEditingController lectureController = TextEditingController();
  final FocusNode lecturerFocusNode = FocusNode();
  final FocusNode lectureFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    lecturerController.addListener(() => _updateFormData(model));
    lectureController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            LecturerValueKey: lecturerController.text,
            LectureValueKey: lectureController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    lecturerController.dispose();
    lecturerFocusNode.dispose();
    lectureController.dispose();
    lectureFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get lecturerValue => this.formValueMap[LecturerValueKey];
  String? get lectureValue => this.formValueMap[LectureValueKey];

  bool get hasLecturer => this.formValueMap.containsKey(LecturerValueKey);
  bool get hasLecture => this.formValueMap.containsKey(LectureValueKey);
}

extension Methods on FormViewModel {}
