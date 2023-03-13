import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlacehorderCont extends StatelessWidget {
  const PlacehorderCont({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context,index){
        return Container(
          height: 50,
          width: 100,
          color: Colors.grey.withOpacity(.5),
        );
      }
      );
  }
}
