import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/setting_page/setting_page.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  int _currentIndex = 0;

  PageController _pageController = PageController();

  final List<BottomNavigationBarItem> _bNBItems = [
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home_outlined),
    ),
    BottomNavigationBarItem(
      label: "",
      icon:  Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag_outlined),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.moped_outlined),
      activeIcon: Icon(Icons.moped_outlined),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings_outlined),)
  ];
  final List<Widget> _pageList = [
    Container(),
    Container(),
    Container(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: PageView(
       children: _pageList,
       controller: _pageController,
       physics: NeverScrollableScrollPhysics(),
     ),
     bottomNavigationBar: BottomNavigationBar(
         showSelectedLabels: false,
         showUnselectedLabels: false,
         onTap: (newValue) {
           if(_currentIndex != newValue) {
             setState(() {

               _pageController.jumpToPage(
                 newValue,
               );
               _currentIndex = newValue;
             });
           }
         },
         type: BottomNavigationBarType.fixed,
         currentIndex: _currentIndex,
         items: _bNBItems
     ),
   );
  }

}