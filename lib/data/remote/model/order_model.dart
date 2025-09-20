class OrderDataModel {
  bool? status;
  String? message;
  List<OrderItemsModel>? orderItemsModel;

  OrderDataModel({this.status, this.message, this.orderItemsModel});

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['orders'] != null) {
      orderItemsModel = <OrderItemsModel>[];
      json['orders'].forEach((v) {
        orderItemsModel!.add(new OrderItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orderItemsModel != null) {
      data['orders'] = this.orderItemsModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemsModel {
  int? id;
  String? totalAmount;
  String? orderNumber;
  String? status;
  String? createdAt;
  List<Product>? product;

  OrderItemsModel(
      {this.id,
        this.totalAmount,
        this.orderNumber,
        this.status,
        this.createdAt,
        this.product});

  OrderItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    orderNumber = json['order_number'];
    status = json['status'];
    createdAt = json['created_at'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_amount'] = this.totalAmount;
    data['order_number'] = this.orderNumber;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? quantity;
  String? price;
  String? image;

  Product({this.id, this.name, this.quantity, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
