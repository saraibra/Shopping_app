
zimport 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/categories_model.dart';
import 'package:shopping_app/Models/home_model.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/cubit.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/states.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(builder: (context, state) {
      ShopCubit cubit = ShopCubit.get(context);
      print(cubit.homeModel.status);
      return ConditionalBuilder(
        condition:
            cubit.homeModel.data != null && cubit.categoriesModel.data != null,
        builder: (context) =>
            buildProducts(cubit.homeModel, cubit.categoriesModel, context),
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    }, listener: (context, state) {
      if (state is ShopSuccessCategoriesState) print('success');
            if (state is ShopSuccessChangeFavouritesState) {
              if(state.model.status== false){
                showToast(message: state.model.message.toString(), color: Colors.red);
              }
            }

    });
  }

  Widget buildProducts(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data!.banners
                    .map((e) => Image(
                          image: NetworkImage(e.image.toString()),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                )),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Catgories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                  ),
                    Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoriesModel.data!.data![index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 8,
                            ),
                        itemCount: categoriesModel.data!.data!.length),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Container(
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1.0 / 1.99,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildGridProduct(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      );
  Widget buildGridProduct(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
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
      );
  Widget buildCategoryItem(DataModel model) => Container(
        width: 100,
        height: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image.toString()),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.8),
                child: Text(
                  model.name.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      );
}
