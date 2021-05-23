import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/screens/home_page/home_page.dart';
import 'dart:async';
import 'package:shoppingapp/screens/home_page/category_list_page.dart';
import 'package:shoppingapp/screens/home_page/product_detail_page.dart';
import 'package:shoppingapp/screens/order_check_page/order_list_page.dart';
import 'package:shoppingapp/screens/setting_page/setting_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/providers/user_provider/user_state_provider.dart';
import 'package:shoppingapp/screens/favorite_list_page/favorite_list_page.dart';
import 'package:shoppingapp/models/notice.dart';
import 'package:shoppingapp/providers/user_provider/notice_state_provider.dart';
import 'package:shoppingapp/providers/firestore_provider.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  var noticeSnapshot;
  StreamSubscription noticeSub;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<BottomNavigationBarItem> _bNBItems = [
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.favorite_border_outlined),
      activeIcon: Icon(Icons.favorite),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.moped_outlined),
      activeIcon: Icon(Icons.moped),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),)
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () =>
        context.read(currentUserProvider).getUserData());
    noticeSnapshot = context.read(firestoreProvider).noticeStream();
    noticeSub = noticeSnapshot.listen((List<Notice> notice) {
      context.read(nowNoticeProvider).fetchNotice(notice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentIndex].currentState.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
            _buildOffstageNavigator(4),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (newValue) {
              setState(() {
                if(_currentIndex == newValue){
                  _navigatorKeys[_currentIndex].currentState.popUntil((route) => route.isFirst);
                }else{
                  _currentIndex = newValue;
                }
              });
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            items: _bNBItems
        ),

      ),
    );
  }
  void _next(Product product) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product,)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          HomePage(
            onPush: _next,
          ),
          CategoryList(
            onPush: _next,
          ),
          FavoriteListPage(
            onPush: _next,
          ),
          OrderListPage(),
          SettingPage(),
        ].elementAt(index);
      },
    };
  }
  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
        offstage: _currentIndex != index,
        child: Navigator(
          key: _navigatorKeys[index],
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
              builder: (context) => routeBuilders[routeSettings.name](context),
            );
          },
        ));
  }
}