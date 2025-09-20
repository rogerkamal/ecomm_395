import 'package:ecomm_395/data/remote/helper/api_helper.dart';

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

}
