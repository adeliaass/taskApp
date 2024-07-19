class UserModel {
  String userName;
  String userId;
  UserModel({required this.userName, required this.userId});

  Map<String, dynamic> toMap() {
    return {"User Name": userName, "User Id": userId};
  }

  factory UserModel.fromMap(Map<String, dynamic> userMap) {
    return UserModel(
        userName: userMap["User Name"], userId: userMap["User Id"]);
  }
}
