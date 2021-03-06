import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:system_settings/system_settings.dart';


class NotificationSettingPage extends StatefulWidget{
  @override
  _NotificationSettingPageState createState() => _NotificationSettingPageState();
}
 
class _NotificationSettingPageState extends State<NotificationSettingPage> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar : TextTitleAppBar(title: "알림 설정"),
      body: FutureBuilder(
        future: checkNotification(),
        builder : (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          if(snapshot.hasData){
            return buildBody(snapshot.data);
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if(mounted)
        setState(() {

        });
    }
  }

  Future<String> checkNotification() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return 'denied';
        case PermissionStatus.granted:
          return 'granted';
        case PermissionStatus.unknown:
          return 'unknown';
        case PermissionStatus.provisional:
          return 'provisional';
        default:
          return null;
      }
    });
  }

  Widget buildBody(String result){
    print(result);
    return SingleChildScrollView(
      child: Column(
        children: [
          if(result != 'granted')
          settingExplanation(),
          SizedBox(height: 20,child: Container(color: Colors.grey[200],)),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("마케팅 정보 알림",style: AppThemes.textTheme.headline1,textAlign: TextAlign.left),
                SizedBox(height: 5,),
                Text("할인 혜택 및 마케팅 정보 알림을 보내드려요",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey[400],fontSize: 13),textAlign: TextAlign.left),
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("SMS 수신 동의"),
                      CupertinoSwitch(
                        activeColor: Color.fromRGBO(0, 204, 0, 1.0), // **ACTIVE STATE COLOR**
                        value: true,
                        onChanged: (value){},
                      )
                    ],
                  ),
                ),





              ],
            ),
          )


        ],
      ),
    );
  }

  Widget settingExplanation(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text("기기 알림을 켜주세요!",style: AppThemes.textTheme.headline1,textAlign: TextAlign.left),
          SizedBox(height: 5,),
          Text("정보 알림을 받기 위해서 기기 알림을 켜주세요",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey[400],fontSize: 13),textAlign: TextAlign.left),
          SizedBox(height: 20,),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 40),
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: 46,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("알림 허용"),
                          CupertinoSwitch(
                            activeColor: Color.fromRGBO(0, 204, 0, 1.0), // **ACTIVE STATE COLOR**
                            value: true,
                              onChanged: (value){}
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("설정 > 알림 > Gunny",style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.grey[500]),),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 60,right: 40),
                alignment: Alignment(1,0.5),
                child: Text("\u{1F446}",style: TextStyle(fontSize: 40),),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
            width: double.infinity,
            height: 50,
            child: RaisedButton(
              onPressed: () async{
                await SystemSettings.appNotifications();
                setState(() {

                });
              },
              color: AppThemes.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)
              ),
              child: Text("기기 알림 켜기",style: AppThemes.textTheme.subtitle1.copyWith(color: Colors.white),),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

}