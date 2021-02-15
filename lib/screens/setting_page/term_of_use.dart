import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/terms_of_use_text.dart';
import 'package:shoppingapp/widgets/drag_scroll_bar.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class TermsOfUse extends StatefulWidget {
  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> with SingleTickerProviderStateMixin{

  final ScrollController agreeController = ScrollController();
  final ScrollController infoController = ScrollController();
  final ScrollController gradeController = ScrollController();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TextTitleAppBar(
         title: "이용약관"
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
              children: <Widget>[
                Container(constraints: BoxConstraints.expand(height: 60),
                  child: TabBar(
                      controller: tabController,
                      indicatorColor: AppThemes.mainColor,
                      indicatorWeight: 3,
                      labelPadding: EdgeInsets.symmetric(vertical: 10.0),// 2번째 Tab Text길이 조정을 위해 적용
                      tabs:[
                        _tabItem("이용약관 동의",0),
                        _tabItem("개인정보처리 방침",1),
                        _tabItem("등급혜택 약관",2),
                      ]),// TabBar 관련 내용 설정
                ),//TabBar 아래부분 선 스타일 조정
                Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                          height: widgetHeight(660),
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: [
                              _termsContent(agreeController,0),//이용약관동의 관련 Text 부분
                              _termsContent(infoController,1),//이용약관동의 관련 Text 부분
                              _termsContent(gradeController,2),//이용약관동의 관련 Text 부분
                            ],)// 개인정보처리 방침 부분
                      )
                  ),
                )
              ]),
        )
    );
  }

  Widget _tabItem(String text,int index){
    return Tab(
      child: Container(
        alignment: Alignment.center,
        child: Text(text,style: AppThemes.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w400,
            color: (tabController.index ==index) ? AppThemes.mainColor : AppThemes.inActiveColor
        ),),
      ),
    );
  }

  Widget _termsContent(ScrollController controller,int index){
    return DraggableScrollbar(
      child: _buildContent(controller,index),
      heightScrollThumb: widgetHeight(80),
      offset : 0,
      controller: controller,
    );
  }

  Widget _buildContent(ScrollController controller,int index) {
    //IOS Scroll 맨 위까지 했을 경우 바운스 해결을 위한 코드 추가
    //IOS 결과 확인 후 코드 수정 요함

    return  NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: SingleChildScrollView(
          controller: controller,
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Container(
              width: size.width,
              margin: EdgeInsets.only(left: 24,top:11),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overScroll){
                  overScroll.disallowGlow();
                  return false;
                },
                child: textOfTerms(index),
              ),
            ), // Listview 안에 Text 내용 작성 (listview안에 적어줘야 scroll과 연결하여 사용 가능하다)
          )),
    );
  }

  Widget textOfTerms(int index){
    switch(index){
      case 0:
        return useTerms();
        break;
      case 1:
        return privacyTerms();
        break;
      case 2:
        return gradeTerms();
        break;
    }
    return Container();
  }
}