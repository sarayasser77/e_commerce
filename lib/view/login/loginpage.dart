import 'package:e_commerce/constants/msgtoast/msg.dart';
import 'package:e_commerce/cubit/loginCubit/logincubit.dart';
import 'package:e_commerce/cubit/loginCubit/statelogin.dart';
import 'package:e_commerce/shared/textfieldregister/textfieldregister.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class LoginView extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener:(context,state){} ,
        builder:(context,state){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,elevation: 0,toolbarHeight: 25,leading:
            InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, 'RegisterScreen');
                },
                child: Icon(Icons.arrow_back,color: Colors.orange,)),),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset('images/register.png'),
                      TextFieldRegister( textonformfield: 'Email', textonvalidation: 'Please Enter your User Name',
                        controller: emailController,
                        validator: (String? value){
                        },),
                      TextFieldRegister(textonformfield: 'Password', textonvalidation: 'Please Enter your Password',
                        controller: passwordController,
                        validator: (String?value){
                        if(value!.length<7){
                          getFlutterToast('Password is too short', Colors.black);
                        }
                        },),
                      const SizedBox(height: 10,),
                     state is! LoginLoadingState?
                     ActionChip(
                          elevation: 0,
                          pressElevation: 20,
                          backgroundColor: Colors.orange,
                          label: Text("            login            ",style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            if( formKey.currentState!.validate()==true){
          LoginCubit.getInstance(context).userLogin(
          email: emailController.text, password: passwordController.text);
          Navigator.push(context, PageTransition(child: HomePage(),
              type: PageTransitionType.fade,childCurrent: this,duration: Duration(seconds: 1))
                           );
                            }}
                      ):
                     Center(
                       child: CircularProgressIndicator(color: Colors.orange,),
                     )

                    ],
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
