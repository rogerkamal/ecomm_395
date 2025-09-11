import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:ecomm_395/domain/constants/app_urls.dart';

class UserRepository {
  ApiHelper apiHelper;

  UserRepository({required this.apiHelper});

  ///register user
  Future<dynamic> registerUser({
    required String name,
    required String email,
    required String password,
    required String mobNo,
  }) async{
    try{
      print("check url ${AppUrls.registrationUrl}");
      return await apiHelper.postApi(url: AppUrls.registrationUrl, mBodyParams: {
        "name": name,
        "email": email,
        "mobile_number": mobNo,
        "password": password
      });
    } catch (e){
      rethrow;
    }
  }

  ///login user
}
