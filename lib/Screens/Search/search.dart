import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/search_model.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/cubit.dart';
import 'package:shopping_app/Screens/Search/cubit/search_cubit.dart';
import 'package:shopping_app/Screens/Search/cubit/search_states.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/style/colors.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Enter text to search';
                          }
                          return null;
                        },
                        onSubmitted: (String text){
                          SearchCubit.get(context).search(text: text);
                        },
                        label: 'Search',
                        icon: Icons.search),
                        SizedBox(height: 10,),
                        if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                         SizedBox(height: 10,),
                      if(state is SearchSuccessState)
                        Expanded(child: ListView.separated(
                itemBuilder: (context, index) => buildSearchItem(context,
                 SearchCubit.get(context).searchModel.data!.data[index]),
                separatorBuilder: (context, index) => myDivder(),
                itemCount: SearchCubit.get(context).searchModel.data!.data.length),)
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
   Widget buildSearchItem(BuildContext context,Product model) =>Padding(
   padding: const EdgeInsets.all(16.0),
   child: Container(
     height: 120,
     child: Row(
              children: [
               Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(model.image.toString()),
                        width: 120,
                        height: 120,
                        
                      ),
                      
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
