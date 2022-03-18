import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/body.dart';
import 'package:flutter_auth/Screens/Login/components/body.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing Controller
  final NameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmpasswordEditingController = new TextEditingController();

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
          //validator: () {},
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
          //validator: () {},
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
            //contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 10),
            hintText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          obscureText: true,
          //validator: () {},
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
            //contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 10),
            hintText: "Confirm Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          obscureText: true,
          //validator: () {},
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
          onPressed: () {},

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
}
