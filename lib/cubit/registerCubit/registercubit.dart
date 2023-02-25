import 'package:e_commerce/constants/endpoint/endpoints.dart';
import 'package:e_commerce/cubit/registerCubit/registerstates.dart';
import 'package:e_commerce/model/dioHelper/diohelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit getInstance(context)=>BlocProvider.of(context);
  void userRegister ({required String email,required String password}){
    emit(RegisterLoadingState());
    try{
      DioHelper.postData(url: '$REGISTER',
          data: {
            'email':email,
            'password':password,
          }
      );
      emit(RegisterSuccessState());
    }catch(error){
      emit(RegisterFailureState(error.toString()));
    }

  }

}

