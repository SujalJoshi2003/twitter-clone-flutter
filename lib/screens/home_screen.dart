import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/dm.dart';
import 'package:twitter_clone/screens/search_user.dart';
import 'package:twitter_clone/screens/tweet_page.dart';
import 'package:twitter_clone/drawer/settings.dart';
import 'package:twitter_clone/utility/make_tweet.dart';
import 'package:twitter_clone/utility/profile.dart';
import 'package:twitter_clone/Navigation/custom_navigation.dart';
// import 'package:twitter_clone/screens/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showScreen = false;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    TweetPage(),
    SearchUser(),
    MakeTweet(),
    DirectMessgae()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
              tooltip: 'Navigate to home'),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Tweet',
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            label: "Message",
            icon: Icon(Icons.message),
          )
        ],
        onTap: (int indexOfItem) {
          setState(() {
            _currentIndex = indexOfItem;
          });
        },
      ),
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              // onTap: () {
              //   navigateWithFadeTransition(context, ProfilePage());
              // }
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
            ListTile(
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
          ],
        ),
      ),
    );
  }
}
