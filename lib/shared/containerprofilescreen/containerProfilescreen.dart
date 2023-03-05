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
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
      ),
      child: Row(
        children: [
          Icon(icon),
        const  SizedBox(width: 30,),
          Text(txt,style:const TextStyle(color: Colors.white,fontSize: 17),)
        ],
      ),
    );
  }
}