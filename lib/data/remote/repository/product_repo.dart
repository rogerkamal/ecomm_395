import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:ecomm_395/domain/constants/app_urls.dart';

class ProductRepo {
  ApiHelper apiHelper;

  ProductRepo({required this.apiHelper});

  Future<dynamic> fetchProducts({int? categoryId}) async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.fetchProductUrl,
        mBodyParams: {"category_id": categoryId},
      );
    } catch (e) {
      rethrow;
    }
  }
}
