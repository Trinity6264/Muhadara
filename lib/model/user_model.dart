class UserModel {
  String? id;
  String? userName;
  String? userEmail;
  UserModel({
    required this.id,
    required this.userName,
    required this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      userName: map['userName'],
      userEmail: map['userEmail'],
    );
  }
}
