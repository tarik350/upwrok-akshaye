import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf_app/resources/auth_methods.dart';
import 'package:pdf_app/styles.dart' as style;
import 'package:pdf_app/views/authenthication/signup_page.dart';
import 'package:pdf_app/views/home.dart';
import 'package:pdf_app/views/pdf_viewer_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/password_reset.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showIdicator = false;

  // final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //var isLogin = false;

    checkIfLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email");
      print(email);
      email == null ? const LoginPage() : const Home();
    }

    // @override
    // initState() {
    //   checkIfLogin();
    //   super.initState();
    // }

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("please enter valid password(min. 6 charater)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final loginButton = Material(
      // elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            /////LOGIN
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("email", "useremail@gmail.com");
            if (_formkey.currentState!.validate()) {
              setState(() {
                showIdicator = true;
              });
              String res = await AuthMethods().loginUser(
                  email: emailController.text,
                  password: passwordController.text);
              setState(() {
                showIdicator = false;
              });
              // signIn(emailController.text, passwordController.text);
              if (res == 'success') {
                Fluttertoast.showToast(msg: "login successful");
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PdfViewerApp()));
              } else {
                Fluttertoast.showToast(msg: res);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            // minWidth: MediaQuery.of(context).size.width,

            backgroundColor: style.Style.DPrimary,
            padding: const EdgeInsets.fromLTRB(120, 15, 120, 15),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: showIdicator
              ? const CircularProgressIndicator()
              : const Text(
                  'login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Pdf Reader app',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 100,
                    child: const CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          AssetImage('assets/images/pdf-reader-logo.png'),
                    ),
                  ),
                  const SizedBox(height: 45),
                  emailField,
                  const SizedBox(height: 20),
                  passwordField,
                  const SizedBox(height: 8),
                  forgotpassword(context),
                  const SizedBox(height: 0),
                  loginButton,
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("dont have an account"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          'sigup',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  // void signIn(String email, String password) async {
  //   if (_formkey.currentState!.validate()) {
  //     await _auth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then((uid) => {
  //               Fluttertoast.showToast(msg: "login successful"),
  //               Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(builder: (context) => EneblaHome()))
  //             })
  //         .catchError((e) {
  //       Fluttertoast.showToast(msg: e!.message);
  //     });
  //   }
  // }

  Widget forgotpassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 85,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "forgot password",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', false);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const reset_password()));
        },
      ),
    );
  }
}
