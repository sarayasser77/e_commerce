import 'package:e_commerce/cubit/cubit.dart';
import 'package:e_commerce/view/OnBoarding/onboardingview.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:e_commerce/view/register/registerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx)=>CommerceCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "BoardingScreen":(context)=>BoardingScreen(),
          "RegisterScreen":(context)=>RegisterView()
        },
        home:BoardingScreen()
      ),
    );
  }
}

