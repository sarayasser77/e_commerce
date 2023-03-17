
import 'package:e_commerce/constants/msgtoast/msg.dart';
import 'package:e_commerce/cubit/userCubit/cubit.dart';
import 'package:e_commerce/cubit/userCubit/cubit.dart';
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDataScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UpdateUserDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CommerceCubit>(context);
    nameController.text = cubit.userModel!.name!;
    phoneController.text = cubit.userModel!.phone!;
    return BlocConsumer<CommerceCubit,CommerceState>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(title: const Text("Update Data"),leading: SizedBox(),
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
                      Image.asset('images/profilr.png',height: 200,width: 150,),
                      TextFormField(
                        controller: nameController,
                        validator: (input)
                        {
                          if( nameController.text.isNotEmpty )
                          {
                            return null;
                          }
                          else
                          {
                            return "Name must not be empty";
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "User Name",
                         focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)
                          )
                        ),

                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone",
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
                            if( nameController.text != cubit.userModel!.name || phoneController.text != cubit.userModel!.phone )
                            {
                              cubit.updateUserData(phone: phoneController.text, name: nameController.text);
                            }
                            else
                            {
                           getFlutterToast('No Data changed', Colors.black);
                            }
                          }
                        },
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text(state is UpdateUserDataLoadingState ? "Loading....." : "Update"),
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
          if( state is UpdateUserDataSuccessState ) Navigator.pop(context);
          if(state is UpdateUserDataSuccessState)return   getFlutterToast('Data updated successfully', Colors.black);
        }
    );
  }
}