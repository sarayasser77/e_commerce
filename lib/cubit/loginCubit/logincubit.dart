import 'dart:convert';
import 'package:e_commerce/constants/endpoint/endpoints.dart';
import 'package:e_commerce/cubit/loginCubit/statelogin.dart';
import 'package:e_commerce/shared/Network/localnetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit getInstance(context)=>BlocProvider.of(context);
  void Login({required String email,required String password}) async {
    emit(LoginLoadingState());
    try{
      Response response=(await http.post(Uri.parse('https://student.valuxapps.com/api/login'),
        body: {
          'email' : email,
          'password' : password,
        },
      ));
      if( response.statusCode == 200 )
      {
        var data = jsonDecode(response.body);
        if( data['status'] == true )
        {
          await CacheNetwork.insertToCache(key: "password", value: password);
          debugPrint("Response is : $data");
          emit(LoginSuccessState(data['message']));
        }
        else
        {
          debugPrint("Response is : $data");
         await CacheNetwork.insertToCache(key: 'token', value: data['data']['token']);
          emit(LoginFailureState(data['message']));
        }
      }
    }
    catch(e){
      debugPrint("Failed to Login , reason : $e");
      emit(LoginFailureState( e.toString()));
    }

  }
}
















//