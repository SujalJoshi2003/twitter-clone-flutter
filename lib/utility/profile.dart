import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/utility/derive_info.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, String> store = {};
  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      Map<String, String> userDetails = await getUserDetails();
      setState(() {
        store = userDetails;
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Edit Profile Picture",
                    ))
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 25, left: 15),
            child: Text(
              store['fullname'] ?? 'Default fullname',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15),
            child: Text(
              // store['username'] ?? 'Default username',
              '@${store['username'] ?? 'Default username'}',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  decoration: TextDecoration.none),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15),
            child: Text(
              "Tweets",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 2, // adjust height for line thickness
            width: double.infinity, // for a horizontal line
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Column(children: []),
          ),
        ],
      ),
    );
  }
}
