import 'package:shoppingapp/models/user.dart';
import 'package:shoppingapp/providers/firestore_provider.dart';
import 'package:shoppingapp/providers/loading_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateProvider = Provider<UserState>((ref) {
  final UserState myUser = ref.watch(currentUserProvider.state);
  return myUser;
});

class UserState {
  final User currentUser;
  final String error;
  UserState({ this.currentUser, this.error});

  UserState copyWith({User currentUser, String error}) {
    return UserState(
        currentUser: currentUser ?? this.currentUser,
        error: error ?? this.error
    );
  }
}

final currentUserProvider = StateNotifierProvider<CurrentUserState>((ref) {
  return CurrentUserState(ref.read);
});

class CurrentUserState extends StateNotifier<UserState> {
  final Reader read;
  static UserState initialUserState = UserState();

  CurrentUserState(this.read) : super(initialUserState);
  Future<void> getUserData() async{
    state = state.copyWith(error:'',currentUser: User());
    User user = await read(firestoreProvider).fetchUserData();
    state = state.copyWith(error: '',currentUser: user);
  }

  updatePhoneNumber(String phoneNumber) async{
    read(nowLoadingStateProvider).onLoading("user");
    Map<String, dynamic> updateData = {
      'phone': phoneNumber
    };
    await read(firestoreProvider).updateUserInfo(updateData);
    read(nowLoadingStateProvider).offLoading("user");
  }

  updateUser(Map<String, dynamic> updateData) async{
    read(nowLoadingStateProvider).onLoading("user");
    await read(firestoreProvider).updateUserInfo(updateData);
    read(nowLoadingStateProvider).offLoading("user");
  }

  updateRefundAccount(List<String> accountInfo) async{
    read(nowLoadingStateProvider).onLoading("user");
    Map<String, dynamic> updateData = {
      'refundAccount': accountInfo
    };
    await read(firestoreProvider).updateUserInfo(updateData);
    getUserData();
    read(nowLoadingStateProvider).offLoading("user");
  }

  updateCharacterImage(int index) async{
    read(nowLoadingStateProvider).onLoading("user");
    state.currentUser.characterIndex = index;
    read(nowLoadingStateProvider).offLoading("user");
  }

  void clear(){
    state = initialUserState;
  }

}