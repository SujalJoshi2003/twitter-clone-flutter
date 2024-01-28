import 'package:flutter/material.dart';
import 'background_video.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'package:flutter/gestures.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final VideoPlayerController _controller =
      VideoControllerSingleton().controller;
  TextEditingController _email = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => JustLogin()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Password change Mail sended",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter an Email",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(_controller),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 75, left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Please Enter your EmailAddress to recieve a",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Mail to change Password",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 10),
                  child: TextField(
                    controller: _email,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't want to change password",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: ' Sign-in',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JustLogin()));
                          },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 45, left: 10, bottom: 20, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: sendPasswordResetEmail,
                    child: Text(
                      "Send Mail",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
