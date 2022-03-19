class UserModel {
  String uid;
  String email;
  String name;

  UserModel({this.uid, this.email, this.name});

  //take data from server

  factory UserModel.fromMap(map) {
    return UserModel(uid: map['uid'], email: map['email'], name: map['name']);
  }

  //send data to server

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'name': name};
  }
}
