class PostContentModel {
  String? audioUrl;
  String? imageurl;
  String? lectureTitle;
  String? lecturerName;
  DateTime? postedAt;
  PostContentModel({
    this.audioUrl,
    this.imageurl,
    this.lectureTitle,
    this.lecturerName,
    this.postedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'audioUrl': audioUrl,
      'imageurl': imageurl,
      'lectureTitle': lectureTitle,
      'lecturerName': lecturerName,
      'postedAt': postedAt?.millisecondsSinceEpoch,
    };
  }

  factory PostContentModel.fromMap(Map<String, dynamic> map) {
    return PostContentModel(
      audioUrl: map['audioUrl'],
      imageurl: map['imageurl'],
      lectureTitle: map['lectureTitle'],
      lecturerName: map['lecturerName'],
      postedAt: map['postedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['postedAt'])
          : null,
    );
  }
}
