import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/providers/user_provider/notice_state_provider.dart';
import 'package:shoppingapp/screens/notice_page/notice_list_page.dart';


class NoticeIcon extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ProviderListener(onChange: (context, notice) {
      if (notice != null &&
          notice.error != null &&
          notice.error.isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text('Error'), content: Text(notice.error));
            });
      }
    }, provider: noticeStateProvider,
        child: body(context, watch(noticeStateProvider))
    );

  }
  Widget body(context, noticeState){
    return InkWell(
        child: Icon((noticeState.noticeOn ?? false) ? Icons.notifications_none_outlined : Icons.notifications_on_outlined,
        color: Colors.black,size : 30,),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoticeListPage()),
          );
        });
  }
}

//알림 없을때는 - Icons.notification_none_outlined 있을때는 Icons.Notification_on_outlined