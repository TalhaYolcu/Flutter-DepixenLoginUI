import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/model/user_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing Controller
  final NameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmpasswordEditingController = new TextEditingController();
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

//name field
    final NameField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
          autofocus: false,
          controller: NameEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            //contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 10),
            hintText: "Name Surname",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value.isEmpty) {
              return ("Name cannot be Empty");
            }
            return null;
          },
          onSaved: (value) {
            NameEditingController.text = value;
          },
          textInputAction: TextInputAction.next,
        ));

//email
    final emailField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
          autofocus: false,
          controller: emailEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            //contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 10),
            hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty) {
              return ("Please Enter Your Email");
            }
            // reg expression for email validation
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Please Enter a valid email");
            }
            return null;
          },
          onSaved: (value) {
            NameEditingController.text = value;
          },
          textInputAction: TextInputAction.next,
        ));

    //password
    final passwordField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
          autofocus: false,
          controller: passwordEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: InkWell(
                child: Icon(
                    isHiddenPassword ? Icons.visibility : Icons.visibility_off),
                onTap: togglePasswordView),
            //contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 10),
            hintText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          obscureText: isHiddenPassword,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value.isEmpty) {
              return ("Password is required for login");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password(Min. 6 Character)");
            }
            return null;
          },
          onSaved: (value) {
            NameEditingController.text = value;
          },
          textInputAction: TextInputAction.next,
        ));

    //confrim password
    final confirmpasswordField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
          autofocus: false,
          controller: confirmpasswordEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: InkWell(
                child: Icon(
                    isHiddenPassword ? Icons.visibility : Icons.visibility_off),
                onTap: togglePasswordView),
            //contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 10),
            hintText: "Confirm Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          obscureText: isHiddenPassword,
          validator: (value) {
            if (confirmpasswordEditingController.text !=
                passwordEditingController.text) {
              return "Password don't match";
            }
            return null;
          },
          onSaved: (value) {
            NameEditingController.text = value;
          },
          textInputAction: TextInputAction.done,
        ));

    //signup button
    final signupButton = Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },

          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          //minWidth: MediaQuery.of(context).size.width / 2,
          color: Colors.blueAccent,
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            //pass to root
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            //margin: EdgeInsets.all(30),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "SIGNUP",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      SvgPicture.asset(
                        "assets/icons/signup.svg",
                        height: 150,
                      ),
                      SizedBox(height: 5),
                      NameField,
                      SizedBox(height: 5),
                      emailField,
                      SizedBox(height: 5),
                      passwordField,
                      SizedBox(height: 5),
                      confirmpasswordField,
                      SizedBox(height: 5),
                      signupButton,
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailsToFirestore();
      }).catchError((e) {
        Fluttertoast.showToast(msg: e?.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //call firestore
    //call user model
    //send data to firebase

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;
    UserModel userModel = UserModel();

    //write all values

    userModel.email = user?.email;
    userModel.uid = user?.uid;
    userModel.name = NameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil(
        this.context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
