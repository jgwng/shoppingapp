import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/faq_question_list.dart';
import 'package:shoppingapp/utils/keyboard_pop.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/search_bar.dart';

class FAQ extends StatefulWidget{
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ>{
  TextEditingController faqSearchController = TextEditingController();

  List<FAQListItem> listOfFAQ = List<FAQListItem>();
  List<FAQListItem> _question = List<FAQListItem>();
  List<FAQListItem> _questionForDisplay = List<FAQListItem>();

  FocusNode faqFocusNode = FocusNode();
  bool isFocused = false;


  @override
  void initState() {
    super.initState();
    faqSearchController.addListener(_onFocusChange);
    listOfFAQ = faqList(context);
    setState(() {
      _question = listOfFAQ;
      _questionForDisplay = listOfFAQ;
    });
  }

  void _onFocusChange() async{
    setState(() {
      isFocused =!isFocused;
    });
  }

  void onTap(){
    setState((){
      faqSearchController.clear();
      _question = listOfFAQ;
      _questionForDisplay = listOfFAQ;
    });
  }

  void onChange(String text){
    setState(() {
      _questionForDisplay = _question.where((questions) {
        return questions.question.contains(text);
      }).toList();
    });
  }

  @override
  void dispose() {
    faqSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TextTitleAppBar(title: "자주하는 질문",),

        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll){
            overScroll.disallowGlow();
            return;
          },
          child:GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async{
              FocusScopeNode currentFocus = FocusScope.of(context);
              await keyboardDown(context);
              if(!currentFocus.hasPrimaryFocus){
                currentFocus.unfocus();
              }
            },
            child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height:widgetHeight(32.48)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: SearchBar(onChange: onChange,controller: faqSearchController,onTap: onTap,
                      hintText: "질문을 검색해주세요.",),
                  ),
                  SizedBox(height:widgetHeight(24.36)),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _questionForDisplay.length,
                    separatorBuilder: (BuildContext context, int index){
                      if(_questionForDisplay[index].type !=_questionForDisplay[index+1].type){
                        return Container(
                            padding: EdgeInsets.only(left: 24,right: 24,top: (index == 0) ? 0 : 50),
                            child : Text(_questionForDisplay[index+1].type,style: AppThemes.textTheme.subtitle1.copyWith(
                                color:Color.fromRGBO(42, 42, 42, 1.0),fontSize: 18,fontWeight: FontWeight.w700
                            ),)
                        );
                      }
                      return Container();
                    },
                    itemBuilder: (context, index) {
                      return _faqItem(_questionForDisplay[index]);
                    },),
                  SizedBox(height:widgetHeight(24.36)),
                ],
              ),
            ),
          ),));
  }

  Widget _faqItem(FAQListItem faq){
    if(faq.type ==""){
      return Container();
    }else{
      return Container(
          padding: EdgeInsets.symmetric(horizontal : 24),
          alignment: Alignment.centerLeft,
          child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppThemes.mainColor,width:2),
                        )),
                    child:
                    GestureDetector(
                      onTap: () => onPressed(faq),
                      child:ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                        title: Text(faq.question,style: AppThemes.textTheme.subtitle1.copyWith(
                            color:Color.fromRGBO(42, 42, 42, 1.0)
                        )),
                        trailing: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: IconButton(icon: faq.isSelected ? Icon(Icons.keyboard_arrow_up,color: AppThemes.mainColor,) : Icon(Icons.keyboard_arrow_down,color: AppThemes.mainColor),
                            onPressed: () => onPressed(faq),),),
                      ),
                    )
                ),
                Visibility(visible: faq.isSelected ? true : false,
                    child: Column(
                      children: [
                        SizedBox(height: widgetHeight(14.5),),
                        Container(
                          padding: EdgeInsets.only(left: 15,top: 15,right:9,bottom: 16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(142, 142, 147, 0.24),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: faq.answer,
                        ),
                        SizedBox(height: widgetHeight(11),),
                      ],
                    )
                ),
              ]
          )
      );
    }
  }

  void onPressed(FAQListItem faq) async{

    setState(() {
      faq.isSelected = !faq.isSelected;

    });
  }



}