import 'package:e_commerce/cubit/userCubit/cubit.dart';
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Favourites extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    CommerceCubit cubit = BlocProvider.of(context);
    return BlocConsumer<CommerceCubit, CommerceState>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text("Favorites",style: TextStyle(color: Colors.grey,fontSize: 25),),
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.grey,),
            body: cubit.favoritesData.isEmpty ?
            const Center(child: Text("No favourites yet."),) :
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.5, vertical: 10),
              child: ListView.builder(
                itemCount: cubit.favoritesData.length,
                itemBuilder: (context, index) {
                  return _favoriteItem(
                    url: cubit.favoritesData[index].image!,
                    title: cubit.favoritesData[index].name!,
                    id: cubit.favoritesData[index].id!.toString(),
                    cubit: cubit,
                    price: cubit.favoritesData[index].price.toInt(),
                    oldPrice: cubit.favoritesData[index].oldPrice.toInt(),
                  );
                },
              ),
            )
        );
      },
    );
  }

  Widget _favoriteItem(
      {required int price, required int oldPrice, required String url, required String title, required String id, required CommerceCubit cubit}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black,),color: Colors.transparent),
      child: Row(
        children:
        [
          Image.network(url, height: 100, width: 100, fit: BoxFit.fill,),
          const SizedBox(width: 20,),
          Expanded(
              child: Column(
                children:
                [
                  Text(title,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:
                    [
                      FittedBox(fit: BoxFit.scaleDown,
                          child: Text(
                            "$price \$", style: TextStyle(fontSize: 13),)),
                      const SizedBox(width: 5,),
                      if( oldPrice != 0 && oldPrice != price)
                        FittedBox(fit: BoxFit.scaleDown,
                            child: Text("$oldPrice \$", style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)))
                    ],
                  ),
                  MaterialButton(
                    color: Colors.orange,
                    height: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.5)
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      cubit.addOrRemoveToOrFromFavorites(productID: id);
                    },
                    child: const Text("Remove"),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}



