import 'package:ecomm_395/data/remote/model/cart_model.dart';

abstract class CartState{}

class CartInitialState extends CartState{}
class CartLoadingState extends CartState{}

/*class CartLoadedState extends CartState{
}*/


class CartSuccessState extends CartState{
  List<CartModel>? allCartItems;

  CartSuccessState({this.allCartItems});

}

class CartCreateOrderSuccessState extends CartState{

  String SuccessMsg;
  CartCreateOrderSuccessState({required this.SuccessMsg});
}




class CartFailureState extends CartState{
  String errorMsg;
  CartFailureState({required this.errorMsg});
}

class CartCreateOrderFailureState extends CartState{
  String errorMsg;
  CartCreateOrderFailureState({required this.errorMsg});
}