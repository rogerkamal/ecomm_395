import 'package:ecomm_395/data/remote/model/user_model.dart';

abstract class UserState{}

class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{}
class UserProfileLoadedState extends UserState{
  UserProfileModel? userProfileData;
  UserProfileLoadedState({required this.userProfileData});
}
class UserFailureState extends UserState{
  String errorMsg;
  UserFailureState({required this.errorMsg});
}
