abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  int productId;
  int qty;

  AddToCartEvent({required this.productId, required this.qty});
}


class FetchCartEvent extends CartEvent{}
class CreateOrderCartEvent extends CartEvent{}




class DecrementQtyEvent extends CartEvent{
  int id;
  int productId;
  int qty;

  DecrementQtyEvent({required this.id,required this.productId,required this.qty});

}


class DeleteCartEvent extends CartEvent{
  int cartId;
  int productId;

  DeleteCartEvent({required this.cartId, required this.productId});
}


