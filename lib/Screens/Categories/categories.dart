import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/categories_model.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/cubit.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/states.dart';
import 'package:shopping_app/shared/componnents/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(
                  ShopCubit.get(context).categoriesModel.data!.data![index]),
              separatorBuilder: (context, index) => myDivder(),
              itemCount: ShopCubit.get(context).categoriesModel.data!.data!.length);
        },
        listener: (context, state) {});
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image.toString()),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
