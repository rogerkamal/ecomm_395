class UserDataModel {
  bool? status;
  String? message;
  UserProfileModel? userProfileModel;

  UserDataModel({this.status, this.message, this.userProfileModel});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userProfileModel = json['data'] != null ? new UserProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userProfileModel != null) {
      data['data'] = this.userProfileModel!.toJson();
    }
    return data;
  }
}

class UserProfileModel {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? password;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  UserProfileModel(
      {this.id,
        this.name,
        this.email,
        this.mobileNumber,
        this.password,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    password = json['password'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['password'] = this.password;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
