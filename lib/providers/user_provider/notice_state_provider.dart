import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/models/notice.dart';
final noticeStateProvider = Provider<NoticeState>((ref) {
  final NoticeState noticeState = ref.watch(nowNoticeProvider.state);
  return noticeState;
});

class NoticeState {
  final bool loading;
  final List<Notice> notice;
  final bool noticeOn;
  final String error;

  NoticeState({this.loading, this.notice, this.noticeOn, this.error});

  NoticeState copyWith({bool loading, List<Notice> notice,bool noticeOn, String error}) {
    return NoticeState(
        loading: loading ?? this.loading,
        notice: notice ?? this.notice,
        noticeOn: noticeOn?? this.noticeOn,
        error: error ?? this.error);
  }
}

final nowNoticeProvider = StateNotifierProvider<NowNoticeState>(
        (ref) {return NowNoticeState(ref.read);}
);

class NowNoticeState extends StateNotifier<NoticeState>{
  final Reader read;
  static NoticeState initialNoticeState = NoticeState();

  NowNoticeState(this.read) : super(initialNoticeState);

  fetchNotice(List<Notice> notice){
    state = state.copyWith(loading: true, error: '');
    bool isOn = false;
    notice.forEach((element) {
      if(element.isRead == false)
        isOn = true;
    });
    state = state.copyWith(loading: false, notice: notice, noticeOn: isOn, error: '');
  }


  sendNoticeNFCM(String title, String body) async {
    DateTime now = DateTime.now();
//    String token = read(userStateProvider).currentUser.token;
//    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'asia-northeast3').httpsCallable('fcmTest');
//    await callable(<String, dynamic>{"title": title, "body": body, "target": token});
//    await read(firestoreProvider).makeNotice(Notice(noticeKey: now.toString(), title: title, content: body, createdAt: now, isRead: false));
  }

  readNotice(String noticeKey) async {
//    await read(firestoreProvider).readNotice(noticeKey);
  }
  deleteNotice(Notice notice, {String uid}) async {
//    await read(firestoreProvider).deleteNotice(notice, uid : uid);
  }

  deleteNotices(List<Notice> notices) async {
//    await read(firestoreProvider).deleteNotices(notices);
  }
  clear(){
    state = initialNoticeState;
  }
}
