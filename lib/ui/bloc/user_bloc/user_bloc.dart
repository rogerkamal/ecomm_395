import 'package:ecomm_395/data/remote/model/user_model.dart';
import 'package:ecomm_395/data/remote/repository/user_repo.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_event.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_state.dart';
import 'package:ecomm_395/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        dynamic res = await userRepository.registerUser(
          name: event.name,
          email: event.email,
          password: event.password,
          mobNo: event.mobNo,
        );

        if (res["status"]) {
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        dynamic res = await userRepository.loginUser(
          email: event.email,
          password: event.password,
        );


        if(res["status"]){
          SharedPreferences? prefs =await SharedPreferences.getInstance();
          prefs.setString(AppConstants.prefUserIdKey, res["tokan"]);

          emit(UserSuccessState());


        } else{
          emit(UserFailureState(errorMsg: res["message"]));
        }

      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });


    on<FetchUserProfileEvent>((event, emit) async {
      emit(UserLoadingState());

      try{
        dynamic res = await userRepository.fetchUserProfile();

        if(res["status"]){

          UserProfileModel? mUserProfile = UserDataModel.fromJson(res).userProfileModel;
          
          emit(UserProfileLoadedState(userProfileData: mUserProfile));

        }else{
          emit(UserFailureState(errorMsg: res["message"]));
        }

      }catch(e){
        emit(UserFailureState(errorMsg: e.toString()));
      }

    });

  }
}
