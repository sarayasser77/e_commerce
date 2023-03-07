import 'dart:convert';

import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:e_commerce/model/bannermodel/bannermodel.dart';
import 'package:e_commerce/model/productmodel/productmodel.dart';
import 'package:e_commerce/model/usermodel/usermodel.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:e_commerce/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

import '../../model/categoryModel/categorymodel.dart';
class CommerceCubit extends Cubit<CommerceState> {
CommerceCubit():super (InitialState());
  static CommerceCubit getInstance(BuildContext context){
    return BlocProvider.of(context);
  }
  List<Widget> screens=[HomePage(),HomePage(),HomePage(),HomePage(),ProfileScreen()];
  int currentIndex=0;
  void changeState({required int index}){
    currentIndex=index;
    emit(ChangeBottomNavBarState());
  }


  ////////////////////////////////////////////////////////////////
 UserModel? userModel;
  BannerModel? bannermodel;
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


//get banners
  List<BannerModel> bannersData=[];
void getBanner()async{

  Response response= (await http.get(Uri.parse("https://student.valuxapps.com/api/banners"),
    headers: {

    'lang':'en'
    }
  )
  );
  var responseBody=jsonDecode(response.body);
  if(responseBody['status']==true){
    for( var item in responseBody['data'] )
    {
      bannersData.add(BannerModel.fromJson(data: item));
    }
    debugPrint("banner data is: ${responseBody['data']}");
    emit(GetBannerSuccessState());
  }else{
    bannersData=[];
    debugPrint("banner data is: ${responseBody['data']}");
    emit(GetBannerFailureState(responseBody['message']));
  }
}
  List<CategoryModel> categoriesData = [];
  // Get Banners Data
  void getCategories() async {
    emit(GetCategoryLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/categories"),
        headers:
        {
          'lang' : 'en'
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['data'] )
      {
        categoriesData.add(CategoryModel.fromJson(data: item));
      }
      print("First Url on Categories Data is : ${categoriesData.first.image}");
      emit(GetCategorySuccessState());
    }
    else
    {
      categoriesData = [];
      print("Banners Data is : $responseBody");
      emit(GetCategoryFailureState());
    }
  }

  //get product
  List<ProductModel> productData = [];
  // Get Banners Data
  void getProducts() async {
    emit(GetProductsLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/home"),
        headers:
        {
          'lang' : 'en'
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['products'] )
      {
        productData.add(ProductModel.fromjson(data: item));
      }
      print("First Url on products Data is : ${productData.first.image}");
      emit(GetProductsSuccessState());
    }
    else
    {
      productData = [];
      print("product Data is : $responseBody");
      emit(GetProductsFailureState());
    }
  }

}