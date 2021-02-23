import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PracticePage extends StatefulWidget{
  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage>{
  ScrollController _scrollViewController;
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white, // app bar color
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    background: Column(
                      children: <Widget>[
                      ],
                    ),
                  ),
                  leading: Container(), // hambuger menu hide
                  expandedHeight: 140, // Tab Bar Height
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.blueAccent, // Tab Bar directive
                    indicatorWeight: 6.0,
                    tabs: <Tab>[
                      Tab(text: "Home"),
                      Tab(text: "Best"),
                      Tab(text: "New"),
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Text('1'),
                Text('2'),
                Text('3'),
              ],
            ),
          )
      ),
    );
  }

}