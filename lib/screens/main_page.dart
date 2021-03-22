import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/home_page/home_page.dart';
import 'package:shoppingapp/screens/home_page/category_list_page.dart';
import 'package:shoppingapp/screens/order_check_page/order_list_page.dart';
import 'package:shoppingapp/screens/setting_page/setting_page.dart';
import 'package:shoppingapp/widgets/app_bar/main_page_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'file:///C:/Users/gwjun/AndroidStudioProjects/shopping_app/lib/providers/user_provider/user_state_provider.dart';

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
    HomePage(),
    CategoryList(),
    OrderList(),
    SettingPage(),
  ];


  final List<String> _titleList = ["Gunny","전체 보기","배송 관리","앱 설정"];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0),()=>context.read(currentUserProvider).getUserData());
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: MainAppBar(title: _titleList[_currentIndex],),
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