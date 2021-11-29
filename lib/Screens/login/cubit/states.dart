import 'package:shopping_app/Models/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
  final LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginChangePasswordVisibilityState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);
}