import 'package:flutter/material.dart';

class ContainerProfileScreen extends StatelessWidget {
  String txt;
  IconData icon;

  ContainerProfileScreen({super.key, required this.icon,required this.txt });
  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Container(
      padding:const EdgeInsets.only(left: 20),
      height: screenHeight*.08,
      width: screenWidth*.8,
      decoration:  BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.transparent.withOpacity(.02),
        // gradient:LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors:[
        //   Colors.orange,
        //   Colors.orange.shade300.withOpacity(.5)
        // ]
        // ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
      ),
      child: Row(
        children: [
          Container(
              height: 50,
              width: 50,
              color: Colors.grey.shade50,
              child: Icon(icon)),
        const  SizedBox(width: 30,),
          Text(txt,style:const TextStyle(color: Colors.black,fontSize: 17),)
        ],
      ),
    );
  }
}
