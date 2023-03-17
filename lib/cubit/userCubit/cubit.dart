import 'dart:convert';

import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:e_commerce/model/bannermodel/bannermodel.dart';
import 'package:e_commerce/model/productmodel/productmodel.dart';
import 'package:e_commerce/model/usermodel/usermodel.dart';
import 'package:e_commerce/view/categoryview/categoryview.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:e_commerce/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

import '../../constants/constants/token.dart';
import '../../model/categoryModel/categorymodel.dart';
import '../../shared/Network/localnetwork.dart';
import '../../view/cartscreen/cartscreen.dart';
import '../../view/favscreen/favouriteScreen.dart';
class CommerceCubit extends Cubit<CommerceState> {
CommerceCubit():super (InitialState());
  static CommerceCubit getInstance(BuildContext context){
    return BlocProvider.of(context);
  }
  List<Widget> screens=[HomePage(),CategoryView(),Favourites(),Carts(),ProfileScreen()];
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
      print("product Data is : $responseBody");
      emit(GetProductsSuccessState());
    }
    else
    {
      productData = [];
      print("product Data is : $responseBody");
      emit(GetProductsFailureState());
    }
  }

  //favourites
  Set<String> favouriteStatus={};
  List<ProductModel> favoritesData = [];
  Future<void> getFavorites() async {
    favoritesData.clear();
    emit(GetFavoritesLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          'lang' : 'en',
          'Authorization' : "CKsUN1oWrv8wQFYz9IpRKtZVModLjtatjdiSRIJFJZB8pAMBhcQOrwURYdc7pgUW05YBMp"
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['data'] )
      {
        favouriteStatus.add(item['product']['id'].toString());
        favoritesData.add(ProductModel.fromjson(data: item['product']));
      }
      debugPrint("Favorites number is : ${responseBody['data']['total']}");
      debugPrint("Favorites Status Number is : ${favouriteStatus.length}");
      emit(GetFavoritesSuccessState());
    }
    else
    {
      favoritesData = [];
      debugPrint("Favorites Data is : $responseBody");
      emit(GetFavoritesFailureState());
    }
  }

  void addOrRemoveToOrFromFavorites({required String productID}) async {
    // عشان يحصل ريفرش في صفحه HomeScreen
    favouriteStatus.contains(productID) == true ? favouriteStatus.remove(productID) : favouriteStatus.add(productID);
    emit(GetFavoritesLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          'lang' : 'en',
          'Authorization' : "CKsUN1oWrv8wQFYz9IpRKtZVModLjtatjdiSRIJFJZB8pAMBhcQOrwURYdc7pgUW05YBMp"
        },
        body:
        {
          "product_id": productID
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      await getFavorites();
      emit(AddOrRemoveFromFavoritesSuccessState());
    }
    else
    {
      emit(AddOrRemoveFromFavoritesFailureState());
    }
  }



  //cart
  Set<String> CartStatus={};
  List<ProductModel> CartsData = [];
  Future<void> getCart() async {
    CartsData.clear();
    emit(GetCartsLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers:
        {
          'lang' : 'en',
          'Authorization' : "CKsUN1oWrv8wQFYz9IpRKtZVModLjtatjdiSRIJFJZB8pAMBhcQOrwURYdc7pgUW05YBMp"
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['cart_items'] )
      {
        CartStatus.add(item['product']['id'].toString());
        CartsData.add(ProductModel.fromjson(data: item['product']));
      }
      debugPrint("cart number is : ${responseBody['data']['total']}");
      debugPrint("cart Status Number is : ${CartStatus.length}");
      emit(GetCartsSuccessState());
    }
    else
    {

      emit(GetCartsFailureState());
    }
  }

  void addOrRemoveToOrFromCart({required String productID}) async {
    // عشان يحصل ريفرش في صفحه HomeScreen
    CartStatus.contains(productID) == true ? CartStatus.remove(productID) : CartStatus.add(productID);
    emit(GetFavoritesLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/carts"),
        headers:
        {
          'lang' : 'en',
          'Authorization' : "CKsUN1oWrv8wQFYz9IpRKtZVModLjtatjdiSRIJFJZB8pAMBhcQOrwURYdc7pgUW05YBMp"
        },
        body:
        {
          "product_id": productID
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      await getCart();
      emit(AddOrRemoveFromCartSuccessState());
    }
    else
    {
      emit(AddOrRemoveFromCartFailureState());
    }
  }
  //search
  List<ProductModel> productFilter=[];
  void filterdData ({required String product}){
    productFilter=productData.where((element) {
      return element.name.toString().toLowerCase().contains(product.toLowerCase());
    }).toList();
    emit(FilterProductsSuccessState());
  }

  void changePassword({required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    String? currentPassword = await CacheNetwork.getCacheData(key: 'password');
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/change-password"),
        body: {
          'current_password' : currentPassword,
          'new_password' : newPassword
        },
        headers: {
          'Authorization' : "CKsUN1oWrv8wQFYz9IpRKtZVModLjtatjdiSRIJFJZB8pAMBhcQOrwURYdc7pgUW05YBMp"
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] )
    {
      CacheNetwork.insertToCache(key: "password", value: newPassword);
      password = newPassword;
      emit(ChangePasswordSuccessState());
    }
    else
    {
      emit(FailedToChangePasswordState());
    }
  }

  void updateUserData({required String phone,required String name}) async {
    emit(UpdateUserDataLoadingState());
    String? currentPassword = await CacheNetwork.getCacheData(key: 'password');
    Response response = await http.put(
        Uri.parse("https://student.valuxapps.com/api/update-profile"),
        body:
        {
          'name' : name,
          'email' : userModel!.email,
          'password' : currentPassword,
          'phone' : phone,
          'image' : userModel!.image,
        },
        headers:
        {
          'Authorization' : "CKsUN1oWrv8wQFYz9IpRKtZVModLjtatjdiSRIJFJZB8pAMBhcQOrwURYdc7pgUW05YBMp"
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] )
    {
      userModel = UserModel.fromJson(responseBody['data']);
      emit(UpdateUserDataSuccessState());
    }
    else
    {
      emit(FailedToUpdateUserDataState());
    }
  }
}