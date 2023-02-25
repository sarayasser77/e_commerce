import 'package:e_commerce/constants/endpoint/endpoints.dart';
import 'package:e_commerce/cubit/loginCubit/statelogin.dart';
import 'package:e_commerce/model/dioHelper/diohelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit getInstance(context)=>BlocProvider.of(context);
  void userLogin ({required String email,required String password}){
    emit(LoginLoadingState());
    try{
      DioHelper.postData(url: '$LOGIN',
          data: {
            'email':email,
            'password':password,
          }
      );
      emit(LoginSuccessState());
    }catch(error){
    emit(LoginFailureState(error.toString()));
    }

  }

}
















//