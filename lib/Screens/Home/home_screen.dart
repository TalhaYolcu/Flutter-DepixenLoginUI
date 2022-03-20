import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedinuser = UserModel();

  @override
  void initState() {
    super.initState();
    //get user information
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loggedinuser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                child: Image.asset(
                  "assets/images/loki-blue-white.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${loggedinuser.name}",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              Text(
                "${loggedinuser.email}",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              //log out button
              ActionChip(
                  label: Text(
                    "Log out",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  //firebase log out
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
