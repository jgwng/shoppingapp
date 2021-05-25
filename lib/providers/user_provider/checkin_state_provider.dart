import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkInStateProvider = Provider<CheckInState>((ref) {
  final CheckInState noticeState = ref.watch(nowCheckInProvider.state);
  return noticeState;
});

class CheckInState {
  final bool loading;
  final bool isEnter;
  final String error;

  CheckInState({this.loading, this.isEnter, this.error});

  CheckInState copyWith({bool loading, bool isEnter,String error}) {
    return CheckInState(
        loading: loading ?? this.loading,
        isEnter: isEnter ?? this.isEnter,
        error: error ?? this.error);
  }
}

final nowCheckInProvider = StateNotifierProvider<NowCheckInState>(
        (ref) {return NowCheckInState(ref.read);}
);

class NowCheckInState extends StateNotifier<CheckInState>{
  final Reader read;
  static CheckInState initialNoticeState = CheckInState();

  NowCheckInState(this.read) : super(initialNoticeState);

  Future<void> fetchCheckInState(bool isEnter) async{
    state = state.copyWith(error:'',isEnter: false,loading: true);

    state = state.copyWith(error:'',isEnter: isEnter,loading: false);
  }


  clear(){
    state = initialNoticeState;
  }
}
