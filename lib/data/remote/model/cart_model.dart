class CartDataModel {
  bool? status;
  String? message;
  List<CartModel>? cartModel;

  CartDataModel({this.status, this.message, this.cartModel});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      cartModel = <CartModel>[];
      json['data'].forEach((v) {
        cartModel!.add(new CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cartModel != null) {
      data['data'] = this.cartModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartModel {
  int? id;
  int? productId;
  String? name;
  String? price;
  int? quantity;
  String? imageUrl;

  CartModel(
      {this.id,
        this.productId,
        this.name,
        this.price,
        this.quantity,
        this.imageUrl});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    imageUrl = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['image'] = this.imageUrl;
    return data;
  }
}
