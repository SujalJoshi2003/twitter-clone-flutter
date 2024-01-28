import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/tweet_story.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
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
        child: Column(children: [
          Text(
            "Tweets of users whom u follow will appear here",
            style: TextStyle(color: Colors.white),
          )
        ]),
      ),
    );
  }
}
