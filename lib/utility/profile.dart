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
    return Column(
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
          padding: EdgeInsets.all(15),
          child: Text(
            store['fullname'] ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(15),
          child: Text(
            store['username'] ?? '',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        SingleChildScrollView(),
      ],
    );
  }
}
