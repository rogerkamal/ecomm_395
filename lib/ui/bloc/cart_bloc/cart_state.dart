import 'package:ecomm_395/data/remote/model/cart_model.dart';

abstract class CartState{}

class CartInitialState extends CartState{}
class CartLoadingState extends CartState{}

/*class CartLoadedState extends CartState{
}*/


class CartSuccessState extends CartState{
  List<CartModel>? allCartItems;

  CartSuccessState({this.allCartItems});
    // ----------------- Getter to calculate total -----------------

  double get totalAmount {
    if (allCartItems == null || allCartItems!.isEmpty) return 0.0;

    double total = 0.0;
    for (var item in allCartItems!) {
      double price = double.tryParse(item.price ?? '0.0') ?? 0.0;
      total += price * (item.quantity ?? 0);
    }
    return total;
  }

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


class DecrementQtyErrorState extends CartState{
  String errorMsg;
  DecrementQtyErrorState({required this.errorMsg});
}


class DecrementQtySuccessState extends CartState{
  String successMsg;
  DecrementQtySuccessState({required this.successMsg});
}

class DeleteCartErrorState extends CartState{
  String errorMsg;
  DeleteCartErrorState({required this.errorMsg});
}
