import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:ecomm_395/domain/constants/app_urls.dart';

class OrderRepository{
  ApiHelper apiHelper;


  OrderRepository({required this.apiHelper});

  Future<dynamic> getAllOrders() async {

    try{
      return await apiHelper.getApi(url: AppUrls.getOrderUrl);
    }catch(e){
      rethrow;
    }
  }



}