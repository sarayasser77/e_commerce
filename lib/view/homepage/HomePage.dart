import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../cubit/userCubit/cubit.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final pageController = PageController();
  int currentIndex = 0 ;
  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    CommerceCubit cubit=BlocProvider.of(context);
    return BlocConsumer<CommerceCubit,CommerceState>(
           builder: (BuildContext context, state) {
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 10,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
             backgroundColor: const Color(0xFFeeeeee).withOpacity(.99),
             body: SafeArea(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Align(
                       alignment: Alignment.center,
                       child: DefaultTextStyle(
                         textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: true),
                         style: TextStyle(fontSize: 30,color: Colors.blueGrey.shade600),
                         child: AnimatedTextKit(
                           totalRepeatCount: 2,
                           animatedTexts: [
                             WavyAnimatedText('Hello at',),
                             WavyAnimatedText('Eraa store'),
                           ],
                           isRepeatingAnimation: true,
                         ),
                       ),
                     ),
                   const SizedBox(height: 5,),
                   cubit.bannersData.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.orange,)):
                       //banners
                   Expanded(
                     flex: 2,
                     child: PageView.builder(
                       physics: const BouncingScrollPhysics(),
                       controller: pageController,
                       itemCount: cubit.bannersData.length,
                       onPageChanged: (index){
                         setState(() {
                           currentIndex = index;
                         });
                       },
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context,index){
                         return SizedBox(
                           width: double.infinity,
                           child:
                               FadeInImage.assetNetwork(placeholder: 'images/loading2.png', image: cubit.bannersData[index].image!,fit: BoxFit.fill,
                                 imageErrorBuilder: (c,v,b){
                                 return Image.asset('images/error.jpg');
                                 },),
                         );
                       },
                     ),
                   ),
                    const SizedBox(height: 10,),
                     //smoothpageindicator
                     Align(
                       alignment: Alignment.center,
                       child:  SmoothPageIndicator(
                           controller: pageController,
                           count:  cubit.bannersData.length,
                           axisDirection: Axis.horizontal,
                           effect: const WormEffect(
                               spacing:  8.0,
                               radius:  10.0,
                               dotWidth:  15.0,
                               dotHeight:  15.0,
                               paintStyle:  PaintingStyle.stroke,
                               strokeWidth:  1.5,
                               dotColor:  Colors.grey,
                               activeDotColor: Colors.orange,
                               type: WormType.thin
                           )
                         // effect: const SlideEffect(

                         //
                         // ),
                       ),
                     ),
                   const SizedBox(height: 10,),
               //categories
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: const [
                         Align(
                             alignment: Alignment.topLeft
                             ,child: Text('Categories',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w900),)),
                         Text('view all',style: TextStyle(color: Colors.orange,fontSize: 20),)
                       ],
                     ),
                     Expanded(
                       flex: 2,
                       child: PageView.builder(
                         physics: const BouncingScrollPhysics(),
                         itemCount: cubit.categoriesData.length,
                         onPageChanged: (index){
                           setState(() {
                             currentIndex = index;
                           });
                         },
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (context,index){
                           return SizedBox(
                             width: double.infinity,
                             child:
                             FadeInImage.assetNetwork(placeholder: 'images/loading2.png',
                               image: cubit.categoriesData[index].image!,fit: BoxFit.contain,
                               imageErrorBuilder: (c,v,b){
                                 return Image.asset('images/error.jpg');
                               },),
                           );
                         },
                       ),
                     ),
                    const Align(
                         alignment: Alignment.topLeft
                         ,child: Text('Products',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w900),)),
                     const SizedBox(height: 5),
                     cubit.productData.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.orange,)):
                     Expanded(flex: 5
                       ,child: GridView.builder(
                         itemCount: cubit.productData.length,
                         scrollDirection: Axis.vertical,
                         itemBuilder: (context,index){
                           return  Container(
                               color: const Color(0xFFffffff).withOpacity(.5),
                               width: 200,
                               height: 200,
                               child: cubit.productData.isEmpty?const CircularProgressIndicator(color: Colors.orange,): Column(
                                   children: [
                                     Expanded(flex: 2,
                                       child: FadeInImage.assetNetwork(placeholder: 'images/loading2.png',
                                       image: cubit.productData[index].image!,fit: BoxFit.fill,
                                         imageErrorBuilder: (c,v,b){
                                         return Image.asset('images/error.jpg');
                                         },),),
                                     Expanded(child:
                                     Text(cubit.productData[index].name!,style: const TextStyle(color: Colors.black,fontSize: 15),maxLines: 2,)),

                                     Padding(
                                       padding: const EdgeInsets.only(top: 10,left: 5,right: 5),
                                       child: Row(

                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text('${cubit.productData[index].price!}'),
                                           const Icon(Icons.favorite_outline_sharp,size: 20,)
                                         ],
                                       ),
                                     ),
                                     const CircleAvatar(backgroundColor: Colors.orange,child: Icon(Icons.shopping_cart_rounded,color: Colors.white,),)
                                   ],
                                 ),

                           );
                         }, gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
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



//ListView.separated(
//                        scrollDirection: Axis.horizontal,
//                          itemCount: 10,
//                          itemBuilder: (context,index){
//                        return Container(
//                          width: screenWidth*.05,
//                          decoration: BoxDecoration(color: Colors.blueGrey),
//                        );
//                      }, separatorBuilder: (BuildContext context, int index) {
//                          return SizedBox();
//                      },
//
//                      )
