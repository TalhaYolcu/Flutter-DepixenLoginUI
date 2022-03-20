//this class represents a user with uid,email and name information
class UserModel {
  String uid;
  String email = "Mail is loading...";
  String name = "Name is loading...";

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
