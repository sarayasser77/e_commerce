import 'dart:convert';

import 'package:e_commerce/constants/endpoint/endpoints.dart';
import 'package:e_commerce/cubit/registerCubit/registerstates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../shared/Network/localnetwork.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit getInstance(context)=>BlocProvider.of(context);
  void register({required String email,required String name,
    required String phone,required String password}) async {
    emit(RegisterLoadingState());
    try{
     Response response=(await http.post(Uri.parse('https://student.valuxapps.com/api/register'),
       body: {
       'name' : name,
       'email' : email,
       'password' : password,
       'phone' : phone,
       'image' : "jdfjfj"     // الصوره مش شغاله بس لازم ابعت قيمه ك value
       },
     ));
      if( response.statusCode == 200 )
      {
        var data = jsonDecode(response.body);
        if( data['status'] == true )
        {
          await CacheNetwork.insertToCache(key: "password", value: password);
          debugPrint("Response is : $data");
          emit(RegisterSuccessState());
        }
        else
        {
          debugPrint("Response is : $data");
          emit(RegisterFailureState(data['message']));
        }
      }
    }
    catch(e){
      debugPrint("Failed to Register , reason : $e");
      emit(RegisterFailureState( e.toString()));
    }

}
}
