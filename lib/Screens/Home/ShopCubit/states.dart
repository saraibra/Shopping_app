import 'package:shopping_app/Models/change_favourites_model.dart';
import 'package:shopping_app/Models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {
  final String error;
  ShopErrorState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavouritesState extends ShopStates {}
class ShopSuccessChangeFavouritesState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavouritesState(this.error);
}
class ShopGetFavouritesState extends ShopStates {}

class ShopGetFavouritesLoadingState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {
}
class ShopGetUsersSuccessState extends ShopStates {
  final LoginModel userModel;

  ShopGetUsersSuccessState({required this.userModel});
}

class ShopGetUsersLoadingState extends ShopStates {}

class ShopErrorGetUsersState extends ShopStates {
}
class ShopUpdateUsersSuccessState extends ShopStates {
  final LoginModel userModel;

  ShopUpdateUsersSuccessState({required this.userModel});
}

class ShopUpdateUsersLoadingState extends ShopStates {}

class ShopErrorUpdateUsersState extends ShopStates {
}