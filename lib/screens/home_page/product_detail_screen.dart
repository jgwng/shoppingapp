import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'dart:math' as math;
class ProductDetailScreen extends StatefulWidget{
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin{
  TabController controller;
  ScrollController _controller;
  ScrollController _controller1;
  bool isTabBarVisible = true;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    _controller1 = ScrollController();
  }

  _scrollListener() {

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {

        print("reach the bottom");
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: false,
      floating: true,
      delegate: AppBarDelegate(
        minHeight: 80.0,
        maxHeight: 80.0,
        child: TabBarView(
          controller: controller,
          children: [
            Container(
              height: 10,
              color: Colors.pink,
            ),
            Container(
              height: 200,
              margin: EdgeInsets.all(5),
              color: Colors.blueGrey,
            ),
            Container(
              height: 200,
              margin: EdgeInsets.all(5),
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
  Widget renderTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: TabBarView(
          controller: controller,
          children: [
            Container(
              height: 10,
              color: Colors.pink,
            ),
            Container(
              height: 200,
              margin: EdgeInsets.all(5),
              color: Colors.blueGrey,
            ),
            Container(
              height: 200,
              margin: EdgeInsets.all(5),
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: isTabBarVisible,
                  forceElevated: false,
                  floating: true,
                  backgroundColor: Colors.white,
                  leading: Container(),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 350,
                          child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.contain),
                        ),
                        SizedBox(height: 20,),
                        Text("제품 이름이 들어갈 공간입니다.",style: AppThemes.textTheme.subtitle1,),
                        SizedBox(height: 10),
                        Text("할인율",style: AppThemes.textTheme.bodyText1,),
                        SizedBox(height: 10),
                        Divider(height: 2,thickness: 1,color: AppThemes.mainColor,),
                        SizedBox(height: 15,),
                        Text("적립 포인트 : 100개",style: AppThemes.textTheme.bodyText1,),
                        SizedBox(height: 5,),
                        Text("배송비 : 없음(무료 배송!)",style: AppThemes.textTheme.bodyText1,),
                        SizedBox(height: 5,),
                        Text("예상 출고일 : 2월 18일",style: AppThemes.textTheme.bodyText1),
                        SizedBox(height: 15),

                      ],
                    ),
                  ),
                  expandedHeight: 580.0,
                  bottom: TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(text: 'POSTS'),
                      Tab(text: 'DETAILS'),
                      Tab(text: 'FOLLOWERS'),
                    ],
                    controller: controller,
                  ),

                ),


              ];
            },
            body: SafeArea(
              child: Builder(
                builder: (context){
                  final _scr = PrimaryScrollController.of(context);
                  _scr.addListener(() {
                    if(_scr.position.pixels == _scr.position.maxScrollExtent-750){
                      print("AAAA");
                    }
                    if (_scr.position.pixels == _scr.position.maxScrollExtent) {
                      print('At DOWNW!!!');
                      print(_scr.position.maxScrollExtent);
                    }
                    if (_scr.position.pixels == _scr.position.minScrollExtent) {
                      setState(() {
                        isTabBarVisible = false;
                      });
                    }
                  });
                  return
                    CustomScrollView(
                    controller: _scr,
                    slivers: [

                      SliverList(
                        delegate: SliverChildListDelegate([

                          Container(height: 30,color: Colors.white,),
                          Container(width: 300,height: 250,color: Colors.red,),
                          Container(width: 300,height: 250,color: Colors.green,),
                          Container(width: 300,height: 250,color: Colors.blue,),
                        ]),
                      ),

                    ],
                  );

                },
              ),
            )
        )
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent =>  _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    return SizedBox.expand(child: Container(
      color: Colors.white, // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
    ));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  AppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(AppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}