import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'background_video.dart';
import 'package:twitter_clone/login/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _fullname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _username = TextEditingController();
  final VideoPlayerController _controller =
      VideoControllerSingleton().controller;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      await users.add({
        'userId': userId,
        'fullname': _fullname.text,
        'email': _email.text,
        'password': _password.text,
        'username': _username.text,
      });
      print("User added");
    } catch (e) {
      final errorMessage = "An error occurred: $e";

      // final snackBarMessage = errorMessage.length > 50
      //     ? "An error occurred. Please check the details."
      //     : errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(_controller),
          SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(top: 60, left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Create your account",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _fullname,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Enter your full name",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  controller: _password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _username,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Enter your username",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await addUser();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => JustLogin()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "User added",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                      ));
                    } catch (e) {
                      final errorMessage = "An error occurred: $e";

                      final snackBarMessage = errorMessage.length > 50
                          ? "An error occurred. Please check the details."
                          : errorMessage;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          snackBarMessage,
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Text("Sign-Up"),
                ),
              ),
              SizedBox(
                height: 55,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Already have an account",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 1, bottom: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JustLogin()));
                  },
                  child: Text(
                    "Sign-in!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
