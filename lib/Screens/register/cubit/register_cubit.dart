import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/login_model.dart';
import 'package:shopping_app/Screens/register/cubit/register_states.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';
import 'package:shopping_app/shared/network/end_point.dart';

class RegisterCubit extends Cubit<ShopRegisterStates> {
  RegisterCubit() : super(ShopRegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShowen = true;
  void changePasswordVisiblity() {
    isPasswordShowen = !isPasswordShowen;
    suffixIcon = isPasswordShowen
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    LoginModel RegisterModel;

    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      print(value.data);
      RegisterModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(RegisterModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
