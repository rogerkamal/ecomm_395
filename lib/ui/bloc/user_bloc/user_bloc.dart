import 'package:ecomm_395/data/remote/repository/user_repo.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_event.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<RegisterUserEvent>((event, emit) async{
      emit(UserLoadingState());

      try {
        dynamic res = await userRepository.registerUser(
            name: event.name,
            email: event.email,
            password: event.password,
            mobNo: event.mobNo);

        if(res["status"]){
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: res["message"]));
        }

      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) {

    });
  }


}