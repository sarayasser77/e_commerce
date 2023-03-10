import 'package:e_commerce/cubit/registerCubit/registercubit.dart';
import 'package:e_commerce/cubit/registerCubit/registerstates.dart';
import 'package:e_commerce/shared/textfieldregister/textfieldregister.dart';
import 'package:e_commerce/view/layoutscreen/layoutscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../constants/msgtoast/msg.dart';

class RegisterView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener:(context,state){
        if(state is RegisterSuccessState){
           Navigator.pushReplacement(context, PageTransition(child:const LayoutScreen(),
               type: PageTransitionType.fade,childCurrent: this,duration:const  Duration(seconds: 1)));
        }else if(state is RegisterFailureState){
          getFlutterToast(state.error, Colors.black);
        }
      } ,
      builder:(context,state){
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,elevation: 0,toolbarHeight: 25,leading:
          InkWell(
              onTap: (){
                Navigator.popAndPushNamed(context, 'BoardingScreen');
              },
              child: Icon(Icons.arrow_back,color: Colors.orange,)),),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('images/register.png'),
                    TextFieldRegister( textonformfield: 'User name', textonvalidation: 'Please Enter your User Name', controller:nameController, isobsecure: false ,),
                    TextFieldRegister(textonformfield: 'Phone', textonvalidation: 'Please Enter your phone', controller: phoneController, isobsecure: false, ),
                    TextFieldRegister(textonformfield: 'Email', textonvalidation: 'Please Enter your Email', controller: emailController, isobsecure: false, ),
                    TextFieldRegister(textonformfield: 'Password', textonvalidation: 'Please Enter your Password',
                     checkPass: true, controller: passwordController, isobsecure: true,),
                    const SizedBox(height: 7,),
                    ActionChip(
                        elevation: 0,
                        pressElevation: 20,
                        backgroundColor: Colors.orange,
                        label:const  Text("            Register            ",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          if(state is RegisterLoadingState){
                            const CircularProgressIndicator(
                              color: Colors.orange,
                            );
                          }else{
                            if( _formKey.currentState!.validate()==true){
                              BlocProvider.of<RegisterCubit>(context).register(email: emailController.text, password: passwordController.text,
                                  phone: phoneController.text, name: nameController.text);



                            }
                          }
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } ,
    );
  }
}
