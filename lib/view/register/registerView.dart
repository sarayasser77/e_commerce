import 'package:e_commerce/constants/msgtoast/msg.dart';
import 'package:e_commerce/shared/textfieldregister/textfieldregister.dart';
import 'package:e_commerce/view/homepage/HomePage.dart';
import 'package:e_commerce/view/login/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RegisterView extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            key: formKey,
            child: Column(
              children: [
               Image.asset('images/register.png'),
                TextFieldRegister( textonformfield: 'User name', textonvalidation: 'Please Enter your User Name',
                  validator: (){}, controller:nameController ,),
                TextFieldRegister(textonformfield: 'Phone', textonvalidation: 'Please Enter your phone', validator: (){}, controller: phoneController, ),
                TextFieldRegister(textonformfield: 'Email', textonvalidation: 'Please Enter your Email', controller: emailController, validator: (){}, ),
                TextFieldRegister(textonformfield: 'Password', textonvalidation: 'Please Enter your Password',
                  validator: (String? value){
                    if(value!.length<7){
                   return getFlutterToast('Password is too short', Colors.black);
                    }else{
                      return null;
                    }
                  }, controller: passwordController,),
               const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an accout?',style: TextStyle(color: Colors.grey,fontSize: 15,),),
                    SizedBox(width: 5,),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, PageTransition(child: LoginView(), type: PageTransitionType.leftToRightPop,childCurrent: this,duration: Duration(seconds: 1)));
                        },
                        child: Text('login',style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.w900),))
                  ],
                ),
               const SizedBox(height: 7,),
                ActionChip(
                  elevation: 0,
                  pressElevation: 20,
                  backgroundColor: Colors.orange,
                    label: Text("            Register            ",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      if( formKey.currentState!.validate()==true){
                        Navigator.push(context, PageTransition(child: HomePage(), type: PageTransitionType.fade,childCurrent: this,duration: Duration(seconds: 1)));

                      }
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
