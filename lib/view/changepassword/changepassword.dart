import 'package:e_commerce/constants/msgtoast/msg.dart';
import 'package:e_commerce/cubit/userCubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants/token.dart';
import '../../cubit/userCubit/states.dart';
class ChangePasswordScreen extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CommerceCubit>(context);
    currentPasswordController.text = password!;
    return BlocConsumer<CommerceCubit,CommerceState>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(title: const Text("Change Password"),leading: SizedBox(),
                foregroundColor: Colors.white,
                centerTitle: true,backgroundColor: Colors.blueGrey.withOpacity(.5),elevation: 0),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [
                      Image.asset('images/password.jpg'),
                      TextFormField(
                        controller: currentPasswordController,
                        validator: (input)
                        {
                          if( currentPasswordController.text == password )
                          {
                            return null;
                          }
                          else
                          {
                            return "Check your password, try again!";
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Current Password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)
                          )
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        obscureText: true,
                        validator: (String? value){
                          if(value==null||value.isEmpty){

                            return "This field must not be empty";
                          }else if(value.length<6){
                            return "password is too short";
                          }
                        },
                        controller: newPasswordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "New Password",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)
                            )
                        ),
                      ),
                      SizedBox(height: 15,),
                      MaterialButton(
                        onPressed: ()
                        {
                          if( formKey.currentState!.validate() )
                          {
                            if(newPasswordController!=password){
                              cubit.changePassword(newPassword: newPasswordController.text);
                              getFlutterToast('password changed', Colors.black);
                            }else{
                              return getFlutterToast('there is no changes', Colors.black);
                            }
                          }
                        },
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text(state is ChangePasswordLoadingState ? "Loading....." : "Change"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context,state)
        {
          if( state is ChangePasswordSuccessState ) Navigator.pop(context);
        }
    );
  }
}