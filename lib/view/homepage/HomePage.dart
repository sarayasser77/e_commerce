import 'package:e_commerce/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommerceCubit,CommerceState>(
           builder: (BuildContext context, state) {
              return Scaffold(
             backgroundColor: Color(0xFFeeeeee).withOpacity(.99),
             bottomNavigationBar: BottomNavigationBar(
               selectedItemColor: Colors.orange,
               unselectedItemColor: Colors.black,
               onTap: (index){
                 BlocProvider.of<CommerceCubit>(context).changeState(index: index);
               },
               currentIndex:  BlocProvider.of<CommerceCubit>(context).currentIndex,
               
               items:const [
                 BottomNavigationBarItem(icon: Icon(Icons.shop),label: "shop"),
                 BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label: "Explore"),
                 BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded),label: "Cart"),
                 BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourite"),
                 BottomNavigationBarItem(icon: Icon(Icons.person),label: "Account"),
               ],),
             body: SafeArea(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Align(
                         alignment: Alignment.topLeft
                         ,child: Text('Eraa store',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),)),
                   SizedBox(height: 5,),
                   Expanded(
                     flex: 3,
                     child: ListView.separated(
                         itemCount: 10,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (context,index){
                       return Container(
                         color: Color(0xFFffffff).withOpacity(.8),
                         width: 150,
                         child: Column(
                           children: [
                             Expanded(child: Image.asset('images/register.png',fit: BoxFit.cover,)),
                             Text('Electronic Device',style: TextStyle(color: Colors.black,fontSize: 15),)
                           ],
                         ),
                       );
                     }, separatorBuilder: (BuildContext context, int index) {
                           return SizedBox(width: 10,);
                     },

                     ),
                   ),
                    const Align(
                         alignment: Alignment.topLeft
                         ,child: Text('Products',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w900),)),
                     SizedBox(height: 5),
                     Expanded(flex: 5
                       ,child: GridView.builder(
                         itemCount: 10,
                         scrollDirection: Axis.vertical,
                         itemBuilder: (context,index){
                           return  Container(
                               color: Color(0xFFffffff).withOpacity(.5),
                               width: 150,
                               height: 200,
                               child:  Column(
                                   children: [
                                     Expanded(child: Image.asset('images/onboarding1.png',fit: BoxFit.cover,)),
                                     Text('Electronic Device',style: TextStyle(color: Colors.black,fontSize: 15),),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Row(

                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text('1900'),
                                           Icon(Icons.favorite_outline_sharp,size: 20,)
                                         ],
                                       ),
                                     ),
                                     CircleAvatar(child: Icon(Icons.shopping_cart_rounded,color: Colors.white,),backgroundColor: Colors.orange,)
                                   ],
                                 ),

                           );
                         }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         crossAxisSpacing: 10,
                         mainAxisSpacing: 10
                       ),

                       ),
                     ),
                   ],
                 ),
               ),
             ),
           );
             },
           listener: (BuildContext context, Object? state) {  },

         );
  }
}
