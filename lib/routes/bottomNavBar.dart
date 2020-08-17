import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../pages/homePage.dart' as home;
import '../pages/searchPage.dart' as search;
import '../pages/settingPage.dart' as setting;

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int indexPage = 0;
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        height: MediaQuery.of(context).size.height * 0.075,
        top: -20,
        curveSize: 70,
        elevation: 4,
        color: Colors.teal[300],
        activeColor: Colors.teal[600],
        backgroundColor: Colors.teal[50],
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.location_searching, title: 'Search'),
          TabItem(icon: Icons.settings, title: 'Setting'),
        ],
        onTap: (indexPage) => print('Clicked index = $indexPage'),
        controller: controller,
      ),
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          home.HomePage(),
          search.SearchPage(),
          setting.SettingPage()
        ],
      ),
    );
  }
}
