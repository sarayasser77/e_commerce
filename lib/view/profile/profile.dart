import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:e_commerce/shared/containerprofilescreen/containerProfilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/userCubit/cubit.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHight=MediaQuery.of(context).size.height ;
    final screenWidth=MediaQuery.of(context).size.width ;
    CommerceCubit cubit=BlocProvider.of(context);
    return BlocConsumer<CommerceCubit,CommerceState>(
      listener: (context,state){},
        builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 100,
            elevation: 0,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              height: screenHight*.14,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))
              ),
              child: TextLiquidFill(
                loadDuration: Duration(seconds: 3),
                waveDuration: Duration(seconds: 2),
                text: 'PROFILE',boxHeight: 70,boxWidth: 150,boxBackgroundColor: Colors.orange,waveColor: Colors.white,textStyle: TextStyle(
                color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700
              ),),
            ),
          ),
        backgroundColor: Colors.white,
        body: cubit.userModel !=null?
        Container(
          height: screenHight,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orange ,
              ),
              SizedBox(height: 10,),
              Text(cubit.userModel!.name.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
              SizedBox(height:10),
              Text(cubit.userModel!.email.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
              SizedBox(height: 30,),
              ContainerProfileScreen(txt: 'Update data', icon:Icons.person,),
              SizedBox(height: 15,),
              ContainerProfileScreen(txt: 'orders', icon:Icons.shopping_basket,),
              SizedBox(height: 15,),
              ContainerProfileScreen(txt: 'favourite', icon:Icons.favorite,),
              SizedBox(height: 15,),
              ContainerProfileScreen(txt: 'logout', icon:Icons.logout,)


            ],
          ),
        ):
        Center(child: CircularProgressIndicator(color: Colors.orange,),)
      );
    },);


  }
}
