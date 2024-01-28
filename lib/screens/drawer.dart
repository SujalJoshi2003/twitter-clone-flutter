import "package:flutter/material.dart";
import 'package:twitter_clone/drawer/settings.dart';
import 'package:twitter_clone/drawer/settings.dart';

class ProfileSlide extends StatefulWidget {
  @override
  _ProfileSlideState createState() => _ProfileSlideState();
}

class _ProfileSlideState extends State<ProfileSlide> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "Soon",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(Icons.person),
              ),
              ListTile(
                title: Text(
                  'Grok',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(Icons.computer),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
                child: ListTile(
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
