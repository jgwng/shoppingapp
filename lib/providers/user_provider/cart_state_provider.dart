import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/providers/firestore_provider.dart';
import 'package:shoppingapp/providers/loading_state_provider.dart';

final cartStateProvider = Provider<CartState>((ref) {
  final CartState cartState = ref.watch(nowCartProvider.state);
  return cartState;
});

class CartState{
  final bool loading;
  final List<Product> cart;
  final String error;

  CartState({this.loading,this.cart,this.error});

  CartState copyWith({bool loading, List<Product> cart, String error}){
    return CartState(
      loading: loading ?? this.loading,
      cart: cart ?? this.cart,
      error: error ?? this.error,
    );
  }
}

final nowCartProvider = StateNotifierProvider<NowCartState>((ref){
  return NowCartState(ref.read);
});

class NowCartState extends StateNotifier<CartState>{
  final Reader read;
  static CartState initialCartState = CartState();
  NowCartState(this.read) : super(initialCartState);

  Future<void> fetchCart() async{
    state = state.copyWith(loading: true,error: '');
    List<Product> cartList = await read(firestoreProvider).fetchCartData();
    state = state.copyWith(cart : cartList, loading: false,error:'');
  }

  addCartItem(Product product) async{
    read(nowLoadingStateProvider).onLoading("cart");
    await read(firestoreProvider).addCartItem(product);
    await fetchCart();
    read(nowLoadingStateProvider).offLoading("cart");
  }

  removeCartItem(Product product) async{
    read(nowLoadingStateProvider).onLoading("cart");
    await read(firestoreProvider).removeCartItem(product);
    await fetchCart();
    read(nowLoadingStateProvider).offLoading("cart");
  }

  clearCart() async{
    read(nowLoadingStateProvider).onLoading("cart");
    await read(firestoreProvider).clearCart();
    state = initialCartState;
    await fetchCart();
    read(nowLoadingStateProvider).offLoading("cart");
  }



}