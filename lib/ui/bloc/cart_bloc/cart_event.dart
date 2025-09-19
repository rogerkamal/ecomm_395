abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  int productId;
  int qty;

  AddToCartEvent({required this.productId, required this.qty});
}
