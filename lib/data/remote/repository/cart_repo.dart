import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/constants/app_urls.dart';

class CartRepository {
  ApiHelper apiHelper;

  CartRepository({required this.apiHelper});

  Future<dynamic> addProductIntoCart({
    required int productId,
    required int qty,
  }) async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.addToCartUrl,
        mBodyParams: {"product_id": productId, "quantity": qty},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchCartItems() async {

    try{
      return await apiHelper.getApi(url: AppUrls.fetchCartUrl);
    }catch(e){
      rethrow;
    }
  }


  Future<dynamic> createOrder() async {

    try{
      return await apiHelper.postApi(url: AppUrls.createOrderUrl);
    }catch(e){rethrow;}

  }


  Future<dynamic> decrementQty({
    required int id,
    required int productId,
    required int qty
}) async {


    try{
      return await apiHelper.postApi(url: AppUrls.decrementQtyUrl,mBodyParams: {
        "product_id":productId,
        "quantity":qty,
        "id": id,
      });
    } catch(e){rethrow;}
}


  Future<dynamic> deleteCart({required int cartId, required int productId}) async {
    try{
      return await apiHelper.postApi(url: AppUrls.deleteCartUrl, mBodyParams: {
        "cart_id" : cartId,
        "product_id" : productId
      });
    }catch(e){rethrow;}
  }


}
