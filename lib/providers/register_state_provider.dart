import 'package:shoppingapp/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firestore_provider.dart';

final registerStateProvider = Provider<RegisterState>((ref) {
  final RegisterState registerState = ref.watch(nowStateProvider.state);
  return registerState;
});

class RegisterState {
  final bool loading;
  final int userState;
  final String error;


  RegisterState({this.loading, this.userState, this.error});

  RegisterState copyWith({bool loading, int userState, String error}) {
    return RegisterState(
        loading: loading ?? this.loading,
        userState: userState ?? this.userState,
        error: error ?? this.error);
  }
}

final nowStateProvider = StateNotifierProvider<NowState>(
        (ref) {return NowState(ref.read);}
);

class NowState extends StateNotifier<RegisterState>{
  final Reader read;
  static RegisterState initialRegisterState = RegisterState();

  NowState(this.read) : super(initialRegisterState);

  Future<void> fetchUserState() async{
    state = state.copyWith(loading: true, error: '');
    try{
      final int userState = await read(firestoreProvider).getUserState();

      state = state.copyWith(loading: false, userState: userState,error: '');
    }catch(e){
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> registerUserData(User user) async {
    state = state.copyWith(loading: true, error: '');
    try{
      await read(firestoreProvider).setUserData(user);
      await fetchUserState();
    }catch(e){
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

}