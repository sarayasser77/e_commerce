import 'dart:convert';

import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:e_commerce/model/usermodel/usermodel.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
class CommerceCubit extends Cubit<CommerceState> {
CommerceCubit():super (InitialState());
  static CommerceCubit getInstance(BuildContext context){
    return BlocProvider.of(context);
  }
  List<Widget> screens=[HomePage(),HomePage(),HomePage(),HomePage(),HomePage()];
  int currentIndex=0;
  void changeState({required int index}){
    currentIndex=index;
    emit(ChangeBottomNavBarState());
  }


  ////////////////////////////////////////////////////////////////
 UserModel? userModel;
void getUserData()async{
emit(GetUserDataloadingState());
  Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/profile"),
      headers:
      {
        'Authorization' : "CKsUN1oWrv8wQFYz9IpRKtZVModLjtatjdiSRIJFJZB8pAMBhcQOrwURYdc7pgUW05YBMp",
      },
  );
  var responseData=jsonDecode(response.body);
  if( responseData['status'] == true )
  {
    userModel = UserModel.fromJson(responseData['data']);
    debugPrint("User Data is : ${responseData['data']}");
    emit(GetUserDataSuccessState());
  }
  else
  {
    emit(GetUserDataFaildState(responseData['message']));
  }

}



}