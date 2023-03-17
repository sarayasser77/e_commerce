import 'package:e_commerce/cubit/userCubit/cubit.dart';
import 'package:e_commerce/cubit/loginCubit/logincubit.dart';
import 'package:e_commerce/cubit/registerCubit/registercubit.dart';
import 'package:e_commerce/shared/Network/localnetwork.dart';
import 'package:e_commerce/shared/blockobserver/blockobserver.dart';
import 'package:e_commerce/view/OnBoarding/onboardingview.dart';
import 'package:e_commerce/view/allproducts/allproducts.dart';
import 'package:e_commerce/view/categoryview/categoryview.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:e_commerce/view/layoutscreen/layoutscreen.dart';
import 'package:e_commerce/view/login/loginpage.dart';
import 'package:e_commerce/view/profile/profile.dart';
import 'package:e_commerce/view/register/registerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/constants/token.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await CacheNetwork.cacheInitialization();
  token=CacheNetwork.getCacheData(key: 'token') ;
  password = await CacheNetwork.getCacheData(key: 'password');
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>CommerceCubit()..getUserData()..getBanner()..getCategories()..getProducts()..getFavorites()..getCart()),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=>LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "BoardingScreen":(context)=>BoardingScreen(),
          "RegisterScreen":(context)=>RegisterView()
        },
        home:BoardingScreen()
        //BoardingScreen()
        //LayoutScreen()
        //token!= null&& token!= ""?LayoutScreen():LoginView()
      ),
    );
  }
}

