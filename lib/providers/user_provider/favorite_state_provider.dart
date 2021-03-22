import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/providers/firestore_provider.dart';
import 'package:shoppingapp/providers/loading_state_provider.dart';

final favoriteStateProvider = Provider<FavoriteState>((ref) {
  final FavoriteState favoriteState = ref.watch(nowFavoriteProvider.state);
  return favoriteState;
});

class FavoriteState{
  final bool loading;
  final List<Product> favoriteList;
  final String error;

  FavoriteState({this.loading,this.favoriteList,this.error});

  FavoriteState copyWith({bool loading, List<Product> favoriteList, String error}){
    return FavoriteState(
      loading: loading ?? this.loading,
      favoriteList: favoriteList ?? this.favoriteList,
      error: error ?? this.error,
    );
  }
}

final nowFavoriteProvider = StateNotifierProvider<NowFavoriteState>((ref){
  return NowFavoriteState(ref.read);
});

class NowFavoriteState extends StateNotifier<FavoriteState>{
  final Reader read;
  static FavoriteState initFavoriteState = FavoriteState();
  NowFavoriteState(this.read) : super(initFavoriteState);

  Future<void> fetchFavorite() async{
    state = state.copyWith(loading: true,error: '');
    List<Product> cartList = await read(firestoreProvider).fetchFavorite();
    state = state.copyWith(favoriteList : cartList, loading: false,error:'');
  }

  addFavoriteItem(Product product) async{
    read(nowLoadingStateProvider).onLoading("cart");
    await read(firestoreProvider).addFavoriteItem(product);
    await fetchFavorite();
    read(nowLoadingStateProvider).offLoading("cart");
  }

  removeFavoriteItem(Product product) async{
    read(nowLoadingStateProvider).onLoading("cart");
    await read(firestoreProvider).removeFavoriteItem(product);
    await fetchFavorite();
    read(nowLoadingStateProvider).offLoading("cart");
  }

  clearCart() async{
    read(nowLoadingStateProvider).onLoading("cart");
    await read(firestoreProvider).clearFavoriteList();
    state = initFavoriteState;
    await fetchFavorite();
    read(nowLoadingStateProvider).offLoading("cart");
  }



}