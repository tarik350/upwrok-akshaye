import 'dart:typed_data';

import 'package:pdf_app/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_app/views/authenthication/login_page.dart';
import 'package:pdf_app/styles.dart' as style;
import 'package:pdf_app/views/home.dart';
import 'package:pdf_app/views/pdf_viewer_app.dart';
import '../../resources/image_tools.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _signupState();
}

class _signupState extends State<SignUp> {
  // final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final firstnameEditingController = TextEditingController();
  final lastnameEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final conformPasswordEditingController = TextEditingController();
  final addressController = TextEditingController();
  bool showProgress = false;

  Uint8List? _image;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstname = TextFormField(
      autofocus: false,
      controller: firstnameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("first name cannot be empty");
        }

        if (!regex.hasMatch(value)) {
          return ("please enter valid first name(min. 3 charater)");
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "first name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final lastname = TextFormField(
      autofocus: false,
      controller: lastnameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("last name cannot be empty");
        }

        if (!regex.hasMatch(value)) {
          return ("please enter valid last name(min. 3 charater)");
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "last name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final phoneNumber = TextFormField(
      autofocus: false,
      controller: phoneNumberEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value?.length != 10)
          return 'Mobile Number must be of 10 digit';
        else
          return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "phoneNumber",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("password is required for login");
        }

        if (!regex.hasMatch(value)) {
          return ("please enter valid password(min. 6 charater)");
        }
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final conformPassword = TextFormField(
      autofocus: false,
      controller: conformPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (conformPasswordEditingController.text !=
            passwordEditingController.text) {
          return "password dont match";
        }
        return null;
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "conformPassword",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final address = TextFormField(
      autofocus: false,
      controller: addressController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("the address is empty");
        }
      },
      onSaved: (Value) {},
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_on),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "address",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          // padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          // minWidth: MediaQuery.of(context).size.width,
          style: ElevatedButton.styleFrom(
            // minWidth: MediaQuery.of(context).size.width,

            backgroundColor: style.Style.DPrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.fromLTRB(120, 15, 120, 15),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            // signup(emailEditingController.text, passwordEditingController.text);

            if (_formkey.currentState!.validate()) {
              setState(() {
                showProgress = true;
              });
              String res = await AuthMethods().signupUser(
                  email: emailEditingController.text,
                  password: passwordEditingController.text,
                  firstname: firstnameEditingController.text,
                  lastname: lastnameEditingController.text,
                  phonenumber: phoneNumberEditingController.text,
                  address: addressController.text,
                  file: _image!);
              print('returned');
              print(res);
              setState(() {
                showProgress = false;
              });
              if (res == 'success') {
                Fluttertoast.showToast(msg: 'account created successfully');

                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => const PdfViewerApp()),
                    (router) => false);
              } else {
                Fluttertoast.showToast(msg: res);
              }
            }
          },
          child: showProgress
              ? const CircularProgressIndicator()
              : const Text(
                  'signUp',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                  /// there will be an image hre
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64, backgroundImage: MemoryImage(_image!))
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                            ),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo)))
                    ],
                  ),
                  const SizedBox(height: 45),
                  firstname,
                  const SizedBox(height: 45),
                  lastname,
                  const SizedBox(height: 20),
                  phoneNumber,
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  emailField,
                  const SizedBox(height: 20),
                  passwordField,
                  const SizedBox(height: 20),
                  conformPassword,
                  const SizedBox(height: 20),
                  address,
                  const SizedBox(height: 15),
                  signupButton,
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  // void signup(String email, String password) async {
  //   if (_formkey.currentState!.validate()) {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     postDetailsToFirestore(userCredential);
  //     //   .then((value) => {postDetailsToFirestore()})
  //     //   .catchError((e) {
  //     // Fluttertoast.showToast(msg: e!.message);
  //     // });
  //   }
  // }

  // postDetailsToFirestore(UserCredential userCredential) async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;

  //   model.User Usermodel = model.User();

  //   Usermodel.email = user!.email;
  //   Usermodel.uid = userCredential.user!.uid;
  //   Usermodel.firstname = firstnameEditingController.text;
  //   Usermodel.lastname = lastnameEditingController.text;

  //   Usermodel.phonenumber = phoneNumberEditingController.text;
  //   Usermodel.address = addressController.text;

  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(Usermodel.toJson());
  //   Fluttertoast.showToast(msg: 'account created successfully');

  //   Navigator.pushAndRemoveUntil(
  //       (context),
  //       MaterialPageRoute(builder: (context) => LoginPage()),
  //       (router) => false);
  // }
}
