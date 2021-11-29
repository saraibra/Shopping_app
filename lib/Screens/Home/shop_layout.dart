import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/cubit.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/states.dart';
import 'package:shopping_app/Screens/Search/search.dart';
import 'package:shopping_app/shared/componnents/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(builder: (context,state){
      ShopCubit cubit =ShopCubit.get(context);
return  Scaffold(
        appBar: AppBar(
          title: Text('Salla'),
          actions: [IconButton(
            onPressed: ()=>navigateTo(context, SearchScreen()),
            icon:Icon( Icons.search),)],
        ),
        body:cubit.screens[cubit.currentIndex],
        
           bottomNavigationBar:  BottomNavigationBar(
          onTap: (index){
            cubit.changeIndex(index);
          },
          currentIndex: cubit.currentIndex,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Home'
          ),
           BottomNavigationBarItem(icon: Icon(Icons.apps),
          label: 'Categories'
          ),
           BottomNavigationBarItem(icon: Icon(Icons.favorite),
          label: 'Favourites'
          ),
           BottomNavigationBarItem(icon: Icon(Icons.settings),
          label: 'Settings'
          ),
        ],),
      );
    }, listener: (context,state){}
    );
  }
}