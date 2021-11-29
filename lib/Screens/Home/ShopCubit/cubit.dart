import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/categories_model.dart';
import 'package:shopping_app/Models/change_favourites_model.dart';
import 'package:shopping_app/Models/favourites_model.dart';
import 'package:shopping_app/Models/home_model.dart';
import 'package:shopping_app/Models/login_model.dart';
import 'package:shopping_app/Screens/Categories/categories.dart';
import 'package:shopping_app/Screens/Favourites/favourites.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/states.dart';
import 'package:shopping_app/Screens/Products/products.dart';
import 'package:shopping_app/Screens/Settings/settings.dart';
import 'package:shopping_app/shared/componnents/constants.dart';
import 'package:shopping_app/shared/network/cashe_helper.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';
import 'package:shopping_app/shared/network/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  Map<int?, bool?> favourites = {};
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel = HomeModel();
  void getHomeData() {
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data!.products.forEach((element) {
        favourites.addAll({element.id: element.inFavourites});
      });
      emit(ShopSuccessState());
    }).catchError((error) {
      emit(ShopErrorState(error.toString()));
    });
  }

  CategoriesModel categoriesModel = CategoriesModel();
  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavouritesModel changeFavouritesModel = ChangeFavouritesModel();
  void changeFavourites(int? productId) {
    if (favourites[productId] == true)
      favourites[productId] = false;
    else
      favourites[productId] = true;
    emit(ShopChangeFavouritesState());

    DioHelper.postData(
        url: FAVOURITES,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      if (changeFavouritesModel.status == false) {
        if (favourites[productId] == true)
          favourites[productId] = false;
        else
          favourites[productId] = true;
      } else {
        getFavouritesData();
      }
      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel));
    }).catchError((error) {
      if (favourites[productId] == true)
        favourites[productId] = false;
      else
        favourites[productId] = true;
      emit(ShopErrorChangeFavouritesState(error.toString()));
    });
  }

  FavouritesModel favouritesModel = FavouritesModel();
  void getFavouritesData() {
    emit(ShopGetFavouritesLoadingState());
    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopErrorGetFavouritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavouritesState());
    });
  }

  LoginModel userModel = LoginModel();
  void getUserData() {
    emit(ShopGetUsersLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {})
        .then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(ShopGetUsersSuccessState(userModel: userModel));
    }).catchError((error) {
      emit(ShopErrorGetUsersState());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopUpdateUsersLoadingState());
    DioHelper.putData(url: PROFILE, token: token, data: {
      'name':name,
      'email':email,
      'phone':phone
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(ShopUpdateUsersSuccessState(userModel: userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUsersState());
    });
  }
}
