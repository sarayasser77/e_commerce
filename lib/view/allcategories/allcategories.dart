import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/userCubit/cubit.dart';
import '../../cubit/userCubit/states.dart';
class ViewAllCategories extends StatelessWidget {

  const ViewAllCategories({super.key});
  @override
  Widget build(BuildContext context) {
    CommerceCubit cubit=BlocProvider.of(context);
    return BlocConsumer<CommerceCubit,CommerceState>(
      builder: (BuildContext context, state) {
        return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.withOpacity(.3),
          title: const Text('Categories',style: TextStyle(fontSize: 25),),
          actions: const [Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search_outlined),
          )],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
          child: GridView.builder(
              itemCount: cubit.categoriesData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20
              ),
              itemBuilder: (context,index){
                return Container(height: 200,width:200,
                  decoration: BoxDecoration(color: Colors.transparent,border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      const Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.favorite_outline_sharp),),
                      ),
                      cubit.categoriesData.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):
                      Expanded(
                          flex: 4,
                          child: FadeInImage.assetNetwork(placeholder: 'images/loading2.jpg',
                            image: cubit.categoriesData[index].image!,fit: BoxFit.fill,
                            imageErrorBuilder: (c,v,b){
                              return Image.asset('images/error.jpg');
                            },)),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(cubit.categoriesData[index].title!,maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.blueGrey),),)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            ...List.generate(3, (index) => Icon(Icons.star_outlined,color: Colors.yellow.shade700,size: 20,)),
                            ...List.generate(2, (index)=> Icon(Icons.star_border_outlined,color: Colors.yellow.shade700,size: 20,)),
                          ]
                      )

                    ],
                  ),
                );
              }),
        ),
      ); },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}
