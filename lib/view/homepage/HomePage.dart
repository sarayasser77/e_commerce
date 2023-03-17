import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:e_commerce/model/productmodel/productmodel.dart';
import 'package:e_commerce/view/allproducts/allproducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../cubit/userCubit/cubit.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductModel? modelpage;
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
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Align(
                         alignment: Alignment.center,
                         child: DefaultTextStyle(
                           textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: true),
                           style: TextStyle(fontSize: 30,color: Colors.black),
                           child: AnimatedTextKit(
                             totalRepeatCount: 2,
                             animatedTexts: [
                               WavyAnimatedText('WELCOME TO',),
                               WavyAnimatedText('KONNECT STORE'),
                             ],
                             isRepeatingAnimation: true,
                           ),
                         ),
                       ),
                     const SizedBox(height: 10,),
                     cubit.bannersData.isEmpty?_loadingWidget()
                         :
                         //banners
                     SizedBox(
                       height: 150,
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
                                 FadeInImage.assetNetwork(placeholder: 'images/loading2.jpg', image: cubit.bannersData[index].image!,fit: BoxFit.fill,
                                   imageErrorBuilder: (c,v,b){
                                   return Image.asset('images/error.jpg');
                                   },),
                           );
                         },
                       ),
                     ),
                      const SizedBox(height: 15,),
                       //smoothpageindicator
                       buildSmoothPageIndicator(cubit),
                     const SizedBox(height: 15,),
                 //categories

                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children:  [
                           const Align(
                               alignment: Alignment.topLeft
                               ,child:Text('Products',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w900),)),
                           GestureDetector(
                               onTap: (){
                                 Navigator.push(context,PageTransition(child: ViewAllProducts(), type: PageTransitionType.topToBottom,duration:const Duration(seconds: 1)));
                               },

                               child: const Text('view all',style: TextStyle(color: Colors.orange,fontSize: 20),))
                         ],
                       ),
                       const SizedBox(height: 5),
                       cubit.productData.isEmpty?_loadingWidget():
                       SizedBox(
                         height: 350,
                         child: GridView.builder(
                           itemCount: 6,
                           scrollDirection: Axis.vertical,
                           itemBuilder: (context,index){
                             return  Container(
                                 color: const Color(0xFFffffff).withOpacity(.5),
                                 width: 250,
                                 height: 300,
                                 child: cubit.productData.isEmpty? _loadingWidget()
                                     : buildSingleChildScrollView(cubit, index,cubit.productData[index]),

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
             ),
           );
             },
           listener: (BuildContext context, Object? state) {  },

         );
  }

  Align buildSmoothPageIndicator(CommerceCubit cubit) {
    return Align(
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
                     );
  }

  SingleChildScrollView buildSingleChildScrollView(CommerceCubit cubit, int index,ProductModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100
            ,child: FadeInImage.assetNetwork(placeholder: 'images/loading2.jpg',
            image: model.image!,fit: BoxFit.fill,
            imageErrorBuilder: (c,v,b){
              return Image.asset('images/error.jpg');
              },),),
          Text(model.name!,style: const TextStyle(color: Colors.black,fontSize: 15),maxLines: 1,),
          Padding(
            padding: const EdgeInsets.only(top:6,left: 5,right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${model.price!}'),
                Row(children:  [
                  IconButton(onPressed: ()
                  {
                    cubit.addOrRemoveToOrFromCart(productID:model.id!.toString());
                  },
                      icon: Icon(Icons.shopping_cart,size: 20,
                        color:  cubit.CartStatus.contains(model.id.toString()) ? Colors.orange : Colors.grey,)),
                  SizedBox(width: 3,),
                  IconButton(onPressed: ()
                  {
                    cubit.addOrRemoveToOrFromFavorites(productID:model.id.toString());
                    },
                      icon: Icon(Icons.favorite,size: 20,
                    color:  cubit.favouriteStatus.contains(model.id.toString()) ? Colors.orange : Colors.grey,))

                                           ],)
                                           ],
                                         ),
                                       ),
                                     ],
                                 ),
                                   );
  }
  Widget _loadingWidget(){
    return const Center(child: CupertinoActivityIndicator());
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




// Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children:  [
//                          const Align(
//                              alignment: Alignment.topLeft
//                              ,child:Text('Categories',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w900),)),
//                          InkWell(
//                              onTap: (){
//                                Navigator.push(context, PageTransition(child: const ViewAllCategories(),
//                                    type: PageTransitionType.topToBottom,duration:const Duration(seconds: 1)));
//                              },
//
//                              child: const Text('view all',style: TextStyle(color: Colors.orange,fontSize: 20),))
//                        ],
//                      ),
//                      Expanded(
//                        flex: 2,
//                        child: PageView.builder(
//                          physics: const BouncingScrollPhysics(),
//                          itemCount: cubit.categoriesData.length,
//                          onPageChanged: (index){
//                            setState(() {
//                              currentIndex = index;
//                            });
//                          },
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (context,index){
//                            return SizedBox(
//                              width: double.infinity,
//                              child:
//                              FadeInImage.assetNetwork(placeholder: 'images/loading2.jpg',
//                                image: cubit.categoriesData[index].image!,fit: BoxFit.contain,
//                                imageErrorBuilder: (c,v,b){
//                                  return Image.asset('images/error.jpg');
//                                },),
//                            );
//                          },
//                        ),
//                      ),