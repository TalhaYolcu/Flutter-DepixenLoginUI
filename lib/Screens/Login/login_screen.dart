import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  //make password visible/invisible
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //email field
    final emailField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
          autofocus: false,
          controller: emailController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          keyboardType: TextInputType.emailAddress,
          //email validity check
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
            emailController.text = value;
          },
          textInputAction: TextInputAction.next,
        ));

    //password field
    final passwordField = Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
          obscureText: isHiddenPassword,
          autofocus: false,
          controller: passwordController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: InkWell(
                child: Icon(
                    isHiddenPassword ? Icons.visibility : Icons.visibility_off),
                onTap: togglePasswordView),
            hintText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          //password validity check
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
            passwordController.text = value;
          },
          textInputAction: TextInputAction.next,
        ));
    //login button
    final loginButton = Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          onPressed: () {
            signIn(emailController.text, passwordController.text);
            //Navigator.pushReplacement(
            //  context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },

          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          //minWidth: MediaQuery.of(context).size.width / 2,
          color: Colors.blueAccent,
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            //margin: EdgeInsets.all(30),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: 250,
                    ),
                    SizedBox(height: 20),
                    emailField,
                    passwordField,
                    loginButton,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blueAccent),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //set state of password visibility
  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
      //toggleIconVisibility();
    });
  }

  //firebase sign in
  void signIn(String email, String password) async {
    if (_formKey.currentState.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e?.message);
      });
    }
  }
}
