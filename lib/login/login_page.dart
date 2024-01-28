import 'package:flutter/material.dart';
import 'package:twitter_clone/login/forgot_password.dart';
import 'package:twitter_clone/login/sign_up.dart';
import 'package:video_player/video_player.dart';
import 'background_video.dart';
import "package:twitter_clone/screens/home_screen.dart";
import 'package:firebase_auth/firebase_auth.dart';

class JustLogin extends StatefulWidget {
  const JustLogin({Key? key}) : super(key: key);
  @override
  JustLoginState createState() => JustLoginState();
}

class JustLoginState extends State<JustLogin> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final VideoPlayerController _controller =
      VideoControllerSingleton().controller;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      // Navigate to the home screen after successful sign-in
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Signed-in",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          VideoPlayer(_controller),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Sign in to your Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
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
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: signIn,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child:
                        Text('Sign-in', style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Don't have an account",
                    style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child:
                        Text("Sign Up", style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
