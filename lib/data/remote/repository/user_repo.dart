import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:ecomm_395/domain/constants/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      return await apiHelper.postApi(url: AppUrls.registrationUrl, mBodyParams: {
        "name": name,
        "email": email,
        "mobile_number": mobNo,
        "password": password
      },isAuthRequest: true);
    } catch (e){
      rethrow;
    }
  }

  ///login user
    Future<dynamic> loginUser({
    required String email,
    required String password,
}) async {
    try {
      return await apiHelper.postApi(url: AppUrls.loginUrl, mBodyParams: {
        "email" : email,
        "password" : password
      },isAuthRequest: true);

    } catch (e){
      rethrow;
    }

    }


    ///fetch user profile
    Future<dynamic> fetchUserProfile() async {
      try {
        return await apiHelper.postApi(url: AppUrls.fetchUserProfileUrl);
      }catch(e){
        rethrow;
      }
    }


}
