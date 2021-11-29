import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/login_model.dart';
import 'package:shopping_app/Screens/login/cubit/states.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';
import 'package:shopping_app/shared/network/end_point.dart';

class LoginCubit extends Cubit<ShopLoginStates> {
  LoginCubit() : super(ShopLoginInitialState());
    static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShowen =true;
  void changePasswordVisiblity() {
    isPasswordShowen = !isPasswordShowen;
        suffixIcon =isPasswordShowen?Icons.visibility_outlined: Icons.visibility_off_outlined;
emit(ShopLoginChangePasswordVisibilityState());
  }

  void userLogin({required String email, required String password}) {
  LoginModel loginModel;

    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {'email': '$email', 'password': '$password'}).then((value) {
      print(value.data);
   loginModel=   LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
