import 'package:objectbox/objectbox.dart';

@Entity()
class OfflineDownloadModel {
  int? id;
  String? audioPath;
  String? imagePath;
  String? lecturerName;
  String? lectureTitle;
  @Property(type: PropertyType.date)
  DateTime? savedAt;
  OfflineDownloadModel({
    this.id = 0,
    this.audioPath,
    this.imagePath,
    this.lecturerName,
    this.lectureTitle,
    this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'audioPath': audioPath,
      'imagePath': imagePath,
      'lecturerName': lecturerName,
      'lectureTitle': lectureTitle,
      'savedAt': savedAt?.millisecondsSinceEpoch,
    };
  }

  factory OfflineDownloadModel.fromMap(Map<String, dynamic> map) {
    return OfflineDownloadModel(
      id: map['id']?.toInt(),
      audioPath: map['audioPath'],
      imagePath: map['imagePath'],
      lecturerName: map['lecturerName'],
      lectureTitle: map['lectureTitle'],
      savedAt: map['savedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['savedAt'])
          : null,
    );
  }
}
