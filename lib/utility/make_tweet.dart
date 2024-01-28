import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/tweet_story.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeTweet extends StatefulWidget {
  @override
  _MakeTweetState createState() => _MakeTweetState();
}

class _MakeTweetState extends State<MakeTweet> {
  late String imageUrl;
  TextEditingController _tweet = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference tweets = FirebaseFirestore.instance.collection('tweets');
  Future<void> addTweet() async {
    try {
      await tweets.add({'tweet': _tweet.text});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Tweet added",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
        ),
      );
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
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0, // Set elevation to 0 to remove the bottom border
          title: Text(
            "Twitter by Sujal",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontStyle: FontStyle.normal),
          ),
          leading: IconButton(
            // alignment: Alignment.center,
            color: Colors.white,
            icon: Icon(Icons.person),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(1.0), // Set the height of the bottom edge
            child: Container(
              color: Colors.grey, // Set the color of the bottom edge
              height: 1.0, // Set the height of the bottom edge
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Tell the world and your followers whats happening!",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _tweet,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: "Make a new Tweet",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: addTweet,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  child: Text(
                    "Tweet",
                    style: TextStyle(color: Colors.black),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
