import 'package:flutter/material.dart';
class TextFieldRegister extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
   TextFieldRegister({required this.textonformfield,required this.textonvalidation,required this.controller,
     this.checkPass=false,required this.isobsecure});
String textonformfield;
String textonvalidation;
 bool ? checkPass ;
 bool isobsecure;
 TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isobsecure,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          errorBorder: OutlineInputBorder(
              borderSide:BorderSide(color: Colors.red) ,
            borderRadius: BorderRadius.circular(20)
          ),
          fillColor:Colors.orange,
          labelText: '$textonformfield',
          labelStyle:TextStyle(color: Colors.orange),
          enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
          validator: (String? value) {
          if( checkPass== true){
            if (value == null || value.isEmpty) {
              return 'please enter $textonvalidation';
            }
            else if(value.length < 6 ) {
              return 'password is short';
            }
          }else{

            if (value == null || value.isEmpty) {
              return 'please enter $textonvalidation';
            }
            else {
              return null;
            }
          }
          }
      ),
    );
  }
}
