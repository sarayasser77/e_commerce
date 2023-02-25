import 'package:e_commerce/view/register/registerView.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/onboardingmodel.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final pageController = PageController();
  int currentIndex = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,toolbarHeight: 15,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                onTap: ()
                {
                  Navigator.pushReplacement(context, PageTransition(child: RegisterView(), type: PageTransitionType.leftToRightWithFade,duration: Duration(seconds: 1)));
                },
                child: Text("Skip",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.grey,
                margin: EdgeInsets.symmetric(vertical: 12.5),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: boardingItems.length,
                  onPageChanged: (index){
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Image.asset(boardingItems[index].image,fit: BoxFit.fill,height: 400,),
                        SizedBox(height: 10,),
                        Text(boardingItems[index].title,style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 19),),
                        SizedBox(height: 20,),
                        Center(
                          child:Text(boardingItems[index].description,style: TextStyle(color: Colors.grey)),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count:  3,
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
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                onTap: ()
                {if( currentIndex < 2 )
                  {
                    pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeIn);
                  }
                  else
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterView()));
                  }
                },
                child:  Text("Next",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            )
          ],
        ),
      ),
    );
  }
}