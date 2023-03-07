
import 'package:e_commerce/cubit/userCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/userCubit/cubit.dart';
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CommerceCubit>(context);
    return BlocConsumer<CommerceCubit,CommerceState>(
        listener: (context,state)
        {

        },
        builder: (context,state){
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.blueGrey,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              currentIndex: BlocProvider.of<CommerceCubit>(context).currentIndex,
              onTap: (currentIndex)
              {
                debugPrint("Current index is : $currentIndex");
                BlocProvider.of<CommerceCubit>(context).changeState(index: currentIndex);
              },
              items:
              const
              [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        }
    );
  }
}