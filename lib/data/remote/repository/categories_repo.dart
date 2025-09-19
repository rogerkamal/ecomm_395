import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:ecomm_395/domain/constants/app_urls.dart';

class CategoriesRepo{

  ApiHelper apiHelper;

  CategoriesRepo({required this.apiHelper});


  Future<dynamic> getCategories() async {
    try {
      return await apiHelper.getApi(url: AppUrls.fetchCategoriesUrl);
    }catch(e){

      rethrow;

    }
}
  

}