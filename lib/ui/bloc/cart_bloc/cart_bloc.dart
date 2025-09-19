import 'package:ecomm_395/data/remote/repository/cart_repo.dart';
import 'package:ecomm_395/ui/bloc/cart_bloc/cart_event.dart';
import 'package:ecomm_395/ui/bloc/cart_bloc/cart_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoadingState());

      try {
        dynamic res = await cartRepository.addProductIntoCart(
          productId: event.productId,
          qty: event.qty,
        );

        if (res["status"] == "true" || res["status"]) {
          emit(CartSuccessState());
        } else {
          emit(CartFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });
  }
}
