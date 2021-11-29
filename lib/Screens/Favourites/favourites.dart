import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/favourites_model.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/cubit.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/states.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/style/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(condition: state is !ShopGetFavouritesLoadingState,
           builder: (context)=>ListView.separated(
                itemBuilder: (context, index) => buildFavItem(context,
                    ShopCubit.get(context).favouritesModel.data!.data[index].product),
                separatorBuilder: (context, index) => myDivder(),
                itemCount: ShopCubit.get(context).favouritesModel.data!.data.length),
                fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }

   
   Widget buildFavItem(BuildContext context,Product? model) =>Padding(
   padding: const EdgeInsets.all(16.0),
   child: Container(
     height: 120,
     child: Row(
              children: [
               Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(model!.image.toString()),
                        width: 120,
                        height: 120,
                        
                      ),
                      if (model.discount != 0)
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        )
                    ],
                  ),
              
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.name.toString()),
                      Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: TextStyle(color: defaultColor, fontSize: 12),
                          ),
                          SizedBox(width: 5),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon:
                                ShopCubit.get(context).favourites[model.id] == true
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(Icons.favorite_border),
                            onPressed: () {
                              ShopCubit.get(context).changeFavourites(model.id);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
   ),
 );
}