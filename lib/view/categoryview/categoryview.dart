import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/userCubit/cubit.dart';
class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CommerceCubit cubit=BlocProvider.of(context);
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return BlocConsumer<CommerceCubit,CommerceState>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey.withOpacity(.3),toolbarHeight: screenHeight*.07,
              title: const Text('Categories',style: TextStyle(color: Colors.white,fontSize: 25),),),
            backgroundColor: Colors.grey.shade100,
            body:  SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: cubit.categoriesData.isEmpty?Center(child: CircularProgressIndicator(color: Colors.orange,),):
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                ListView.separated(itemBuilder: (context,index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: screenHeight*.15,
                          width: screenWidth*.38,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: FadeInImage.assetNetwork(placeholder: 'images/loading2.jpg',
                              image: cubit.categoriesData[index].image!,fit: BoxFit.contain,
                                imageErrorBuilder: (c,v,b){
                                  return Image.asset('images/error.jpg');
                                },),
                      ),
                       Text(cubit.categoriesData[index].title!,
                        maxLines: 4,overflow: TextOverflow.ellipsis,),
                      const Icon(Icons.arrow_forward_ios_outlined,size: 20,)
                    ],
                  );
                }, separatorBuilder: (BuildContext context,  index){
                  return  Column(children: const [
                    SizedBox(height: 10,),
                    Divider(
                      height: 10,
                      indent: 40,
                      endIndent: 40,
                      thickness: 1,
                    ),
                    SizedBox(height: 10,)
                  ],);

                }, itemCount:cubit.categoriesData.length,
                ),
              ),
            )
        );
      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}
