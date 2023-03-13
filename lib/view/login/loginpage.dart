import 'package:e_commerce/shared/textfieldregister/textfieldregister.dart';
import 'package:e_commerce/view/layoutscreen/layoutscreen.dart';
import 'package:e_commerce/view/register/registerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../constants/msgtoast/msg.dart';
import '../../cubit/loginCubit/logincubit.dart';
import '../../cubit/loginCubit/statelogin.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: 'logins');
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
      listener:(context,state){if(state is LoginSuccessState){
        getFlutterToast(state.msg, Colors.black);
        Navigator.pushReplacement(context, PageTransition(child:const LayoutScreen(),
              type: PageTransitionType.fade,childCurrent: this,duration:const  Duration(seconds: 1)));
        }else if(state is LoginFailureState){
        getFlutterToast(state.error, Colors.black);
      }
      } ,
      builder:(context,state){
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,elevation: 0,toolbarHeight: 25,leading: const SizedBox()
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('images/register.png'),
                  TextFieldRegister(textonformfield: 'Email', textonvalidation: 'Please Enter your Email', controller: emailController, isobsecure: false, ),
                  TextFieldRegister(textonformfield: 'Password', textonvalidation: 'Please Enter your Password',
                    checkPass: true, controller: passwordController, isobsecure: true,),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Make new Account?',style: TextStyle(color: Colors.grey,fontSize: 15,),),
                      const SizedBox(width: 5,),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: RegisterView(), type: PageTransitionType.leftToRightPop,childCurrent: this,duration:const Duration(seconds: 1)));
                          },
                          child: const Text('Register',style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.w900),))
                    ],
                  ),

                  const SizedBox(height: 10,),
                  State is LoginLoadingState?
                  const CircularProgressIndicator(color: Colors.orange,):
                  ActionChip(
                      elevation: 0,
                      pressElevation: 20,
                      backgroundColor: Colors.orange,
                      label:const  Text("            Login            ",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        if( _formKey.currentState!.validate()==true){
                          BlocProvider.of<LoginCubit>(context).Login(email: emailController.text, password: passwordController.text,
                          );
                        }
                      }
                  )
                ],
              ),
            ),
          ),
        );
      } ,
    );
  }
}

