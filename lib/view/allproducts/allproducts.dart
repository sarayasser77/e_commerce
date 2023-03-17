import 'package:e_commerce/cubit/userCubit/cubit.dart';
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:e_commerce/model/productmodel/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ViewAllProducts extends StatefulWidget {
  ViewAllProducts({super.key});

  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  @override
  Widget build(BuildContext context) {
    ProductModel? model;
    CommerceCubit cubit=BlocProvider.of(context);
    return BlocConsumer<CommerceCubit,CommerceState>(
      builder: (BuildContext context, state) { return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.withOpacity(.3),
          title: const Text('Products',style: TextStyle(fontSize: 25),),
          actions: const [Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search_outlined),
          )],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),

          child: Column(
            children: [
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (value){
                  cubit.filterdData(product: value);
                },
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.black),
                  errorBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black) ,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  fillColor:Colors.orange,
                  labelText: 'Search',
                  labelStyle:TextStyle(color: Colors.black),
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: GridView.builder(
                    itemCount:cubit.productFilter.isEmpty? cubit.productData.length:cubit.productFilter.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20
                    ),
                    itemBuilder: (context,index){
                      return buildAllProduct(
                          cubit ,
                          cubit.productFilter.isEmpty?cubit.productData[index]:cubit.productFilter[index],
                          index);
                    }),
              ),
            ],
          ),
        ),
      ); },
      listener: (BuildContext context, Object? state) {  },

    );
  }

  Container buildAllProduct(CommerceCubit cubit, ProductModel model, int index) {
    return Container(
      height: 200,width:200,
    decoration: BoxDecoration(color: Colors.transparent,border: Border.all(color: Colors.black)),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40,),
            cubit.productData.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):
            Expanded(
              child: SizedBox(
                  height: 70,
                  width: 70,
                  child: FadeInImage.assetNetwork(placeholder: 'images/loading2.jpg',
                    image: cubit.productData[index].image!,fit: BoxFit.fill,
                    imageErrorBuilder: (c,v,b){
                      return Image.asset('images/error.jpg');
                    },)),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: ()
                      {
                        cubit.addOrRemoveToOrFromFavorites(productID:model.id.toString());
                      },
                      icon: Icon(Icons.favorite,size: 22,
                        color:  cubit.favouriteStatus.contains(model.id.toString()) ? Colors.orange : Colors.grey,))
              ),
            ),
          ],
        ),


         Expanded(
           child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(cubit.productData[index].description!,maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.blueGrey),),)),
         ),

                Expanded(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children:[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(cubit.productData[index].price!.toString()),
      ),
      ...List.generate(3, (index) => Icon(Icons.star_outlined,color: Colors.yellow.shade700,size: 20,)),
      ...List.generate(2, (index)=> Icon(Icons.star_border_outlined,color: Colors.yellow.shade700,size: 20,)),
      ]
    ),
                )

      ],
    ),
                );
  }
}
