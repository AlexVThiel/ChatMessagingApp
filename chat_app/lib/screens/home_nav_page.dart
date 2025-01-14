import 'package:chat_app/screens/profile/main_profile_page.dart';
import 'package:flutter/material.dart';

import 'chats/main_chat_page.dart';
import 'home_page.dart';

class HomeNavPage extends StatefulWidget {
  int tabIndex = 0;
  static const routeName = '/mainPage';
  HomeNavPage({
    super.key,
    required this.tabIndex,
  });

  @override
  State<HomeNavPage> createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  static const List originalList = [
    HomePage(),
    MainChatPage(),
    MainProfilePage(),
  ];
  int _tabIndex = 0;
  Color tabColor = Colors.white;
  Color selectedTabColor = const Color(0XFF152C70);
  Color unSelectedTabColor = const Color(0XFFA7B3CC);
  Color textColor = const Color(0XFF474747);

  final _drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _selectedTab(widget.tabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        bottomNavigationBar: _buildTabBar(),
        body: Center(
          child: originalList.elementAt(_tabIndex),
        ));
  }

  void _selectedTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  Widget _buildTabBar() {
    return BottomNavigationBar(
      selectedItemColor: selectedTabColor,
      unselectedItemColor: unSelectedTabColor,
      selectedLabelStyle: TextStyle(color: selectedTabColor),
      unselectedLabelStyle: TextStyle(color: unSelectedTabColor),
      showUnselectedLabels: true,
      currentIndex: _tabIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: tabColor,
          icon: Icon(Icons.home_filled),
          label: 'Home',
          activeIcon: Icon(
            Icons.home,
            size: 24,
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: tabColor,
          icon: Icon(Icons.messenger),
          activeIcon: Icon(
            Icons.messenger_outline,
            size: 24,
          ),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          backgroundColor: tabColor,
          icon: Icon(Icons.person_2),
          activeIcon: Icon(
            Icons.person_2_outlined,
            size: 24,
          ),
          label: 'Profile',
        ),
      ],
      onTap: _selectedTab,
    );
  }
}
