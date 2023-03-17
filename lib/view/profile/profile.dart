import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:e_commerce/shared/containerprofilescreen/containerProfilescreen.dart';
import 'package:e_commerce/view/cartscreen/cartscreen.dart';
import 'package:e_commerce/view/changepassword/changepassword.dart';
import 'package:e_commerce/view/favscreen/favouriteScreen.dart';
import 'package:e_commerce/view/updatedata/updatedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';
import '../../cubit/userCubit/cubit.dart';

File? imageFile;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHight=MediaQuery.of(context).size.height ;
    final screenWidth=MediaQuery.of(context).size.width ;
    CommerceCubit cubit=BlocProvider.of(context);
    return BlocConsumer<CommerceCubit,CommerceState>(
      listener: (context,state){},
        builder: (context,state){
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 90,
            elevation: 0,
            flexibleSpace: Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              height: screenHight*.14,
              decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
              ),
              child: TextLiquidFill(
                loadDuration: const Duration(seconds: 3),
                waveDuration: const Duration(seconds: 2),
                text: 'PROFILE',boxHeight: 70,boxWidth: 150,boxBackgroundColor: Colors.orange,waveColor: Colors.white,textStyle: const TextStyle(
                color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700
              ),),
            ),
          ),
        backgroundColor: Colors.white,
        body: cubit.userModel !=null?
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               (imageFile !=null)?
                   Stack(
                     children: [
                       CircleAvatar(
                         radius: 70,
                         backgroundColor: Colors.transparent.withOpacity(.1) ,
                         backgroundImage: FileImage((File(imageFile!.path)),

                         ),
                       ),
                       Positioned(
                         top: 100,
                         left: 90,
                         child: InkWell(
                             onTap: (){
                               getImage();
                             },
                             child:const Align(
                                 alignment: Alignment.center,
                                 child: CircleAvatar(child: Icon(Icons.camera_alt_outlined)))

                         ),
                       ),
                     ],
                   )
                  :
               Stack(
                 children: [
                   CircleAvatar(
                     radius: 70,
                     backgroundColor: Colors.transparent.withOpacity(.1) ,
                   ),
                   Positioned(
                     top: 100,
                     left: 90,
                     child: InkWell(
                         onTap: (){
                           getImage();
                         },
                         child:const Align(
                             alignment: Alignment.center,
                             child: CircleAvatar(child: Icon(Icons.camera_alt_outlined)))

                     ),
                   ),
                 ],
               ),

                const SizedBox(height: 10,),
                Text(cubit.userModel!.name.toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                const SizedBox(height:10),
                Text(cubit.userModel!.email.toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                const SizedBox(height: 30,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context,PageTransition(child: UpdateUserDataScreen(), type: PageTransitionType.fade,duration:const Duration(seconds: 2)));
                    },
                    child: ContainerProfileScreen(txt: 'Update Data', icon:Icons.person,)),
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context,PageTransition(child: ChangePasswordScreen(), type: PageTransitionType.fade,duration:const Duration(seconds: 2)));
                    },
                    child: ContainerProfileScreen(txt: 'Change password', icon:Icons.password,)),
                const SizedBox(height: 15,),
                GestureDetector(
                    onTap:(){
                      Navigator.push(context, PageTransition(child: Carts(), type: PageTransitionType.leftToRightWithFade,duration:const Duration(seconds: 2)));
                    } ,
                    child: ContainerProfileScreen(txt: 'orders', icon:Icons.shopping_basket,)),
                const SizedBox(height: 15,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: Favourites(), type: PageTransitionType.leftToRightWithFade,duration:const Duration(seconds: 2)));
                    },
                    child: ContainerProfileScreen(txt: 'favourite', icon:Icons.favorite,)),
                const SizedBox(height: 15,),
                GestureDetector(
                    onTap: (){
                      showDialog(context: context,
                          builder: (context)=>AlertDialog(
                        content: Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: [
                              Text('Are you sure to log out ?'),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:   [
                                  ActionChip(
                                   backgroundColor: Colors.orange,
                                    label: const Text('      yes      ',style: TextStyle(color: Colors.white),),
                                  onPressed: (){
                                     Navigator.pop(context);
},
                                  ),
                                  SizedBox(width: 10,),
                                  ActionChip(
                                    backgroundColor: Colors.orange,
                                    label: const Text('       No       ',style: TextStyle(color: Colors.white),

                                  ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ));
                    },
                    child: ContainerProfileScreen(txt: 'logout', icon:Icons.logout,)),
                SizedBox(height: 10,),


              ],
            ),
          ),
        ):
        const Center(child: CircularProgressIndicator(color: Colors.orange,),)
      );
    },
    );


  }

  void getImage()async{
  final selectedImage= await ImagePicker().getImage(source: ImageSource.gallery);
  if(selectedImage!=null){
   setState(() {
     imageFile=File(selectedImage.path);
   });
  }
  }
}
