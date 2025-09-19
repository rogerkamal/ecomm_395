class CategoryDataModel {
  bool? status;
  String? message;
  List<CategoryModel>? categoryModel;

  CategoryDataModel({this.status, this.message, this.categoryModel});

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      categoryModel = <CategoryModel>[];
      json['data'].forEach((v) {
        categoryModel!.add(new CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categoryModel != null) {
      data['data'] = this.categoryModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryModel {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  CategoryModel({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
