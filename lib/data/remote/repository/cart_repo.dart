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
}
