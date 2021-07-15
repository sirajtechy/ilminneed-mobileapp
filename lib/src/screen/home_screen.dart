import 'package:flutter/material.dart';
import 'package:ilminneed/src/screen/category.dart';
import 'package:ilminneed/src/screen/explore.dart';
import 'package:ilminneed/src/screen/myaccount.dart';
import 'package:ilminneed/src/screen/mycourses.dart';
import 'package:ilminneed/src/screen/search.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';


class HomeScreen extends StatefulWidget {
  int currentTab = 0;
  int selectedTab = 0;
  Widget currentPage = ExploreScreen();

  HomeScreen({
    Key key,
    this.currentTab,
  }) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  Widget chipContainer(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: konLightColor2),
      child: Text(
        label,
        style: smallTextStyle().copyWith(color: konBlackColor),
      ),
    );
  }

  void _onItemTapped(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      widget.selectedTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = ExploreScreen();
          break;
        case 1:
          widget.currentPage = Category();
          break;
        case 2:
          widget.currentPage = MyCourses();
          break;
        case 3:
          widget.currentPage = MyAccountScreen();
          break;
      }
    });

  }

  @override
  initState() {
    _onItemTapped(widget.currentTab);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor2,
      body: widget.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_outlined,
            ),
            label: 'My courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_identity_outlined,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: widget.selectedTab,
        selectedItemColor: konTextInputBorderActiveColor,
        unselectedItemColor: konDarkColorD3,
        onTap: _onItemTapped,
        selectedLabelStyle: smallTextStyle().copyWith(fontSize: 10, color: konTextInputBorderActiveColor),
        unselectedLabelStyle: smallTextStyle().copyWith(fontSize: 10, color: konDarkColorD3),
      ),
    );
  }


}
