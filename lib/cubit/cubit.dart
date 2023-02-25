import 'package:e_commerce/cubit/states.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}