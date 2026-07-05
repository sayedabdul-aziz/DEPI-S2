class UserModel {
  String? uid;
  String? email;
  String? name;
  String? image;
  String? userType;

  UserModel({this.uid, this.email, this.name, this.image, this.userType});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      image: json['image'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['name'] = name;
    data['image'] = image;
    data['userType'] = userType;
    return data;
  }
}
