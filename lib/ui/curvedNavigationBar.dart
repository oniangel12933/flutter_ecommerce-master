import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommers/ui/page-1/home.dart';
import 'package:flutter_ecommers/ui/page-2/feedAdmin.dart';
import 'package:flutter_ecommers/ui/page-3/userProfile.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _tabItems = [HomePage(), FeedsAdmin(), UserProfile()];
  int _activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF016DF7),
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.home, size: 24, color: Colors.white),
          Icon(Icons.dynamic_feed_sharp, size: 24, color: Colors.white),
          Icon(Icons.person, size: 24, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      body: _tabItems[_activePage],
    );
  }
}
