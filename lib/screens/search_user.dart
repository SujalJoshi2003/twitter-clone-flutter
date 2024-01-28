import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
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
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.normal),
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Text(
                  "Search users from here",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
