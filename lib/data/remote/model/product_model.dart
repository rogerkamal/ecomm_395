class ProductDataModel {
  bool? status;
  String? message;
  List<ProductModel>? productModel;

  ProductDataModel({this.status, this.message, this.productModel});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      productModel = <ProductModel>[];
      json['data'].forEach((v) {
        productModel!.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productModel != null) {
      data['data'] = this.productModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  dynamic id;
  String? name;
  String? price;
  String? image;
  dynamic categoryId;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  ProductModel(
      {this.id,
        this.name,
        this.price,
        this.image,
        this.categoryId,
        this.status,
        this.createdAt,
        this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
