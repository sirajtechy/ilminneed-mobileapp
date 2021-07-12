import 'package:flutter/material.dart';
import 'package:ilminneed/src/screen/category.dart';
import 'package:ilminneed/src/screen/explore.dart';
import 'package:ilminneed/src/screen/quiz.dart';
import 'package:ilminneed/src/screen/search.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Widget currentPage = ExploreScreen();

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
    print(tabItem);
    setState(() {
      _selectedIndex = tabItem;
      switch (tabItem) {
        case 0:
          currentPage = ExploreScreen();
          break;
        case 1:
          currentPage = SearchScreen();
          break;
        case 2:
          currentPage = Category();
          break;
        case 3:
          currentPage = QuizScreen();
          break;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor2,
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
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
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_identity_outlined,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: konTextInputBorderActiveColor,
        unselectedItemColor: konDarkColorD3,
        onTap: _onItemTapped,
        selectedLabelStyle: smallTextStyle().copyWith(fontSize: 10, color: konTextInputBorderActiveColor),
        unselectedLabelStyle: smallTextStyle().copyWith(fontSize: 10, color: konDarkColorD3),
      ),
    );
  }


}
