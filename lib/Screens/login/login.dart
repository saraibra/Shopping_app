import 'package:bloc/bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Screens/Home/shop_layout.dart';
import 'package:shopping_app/Screens/login/cubit/cubit.dart';
import 'package:shopping_app/Screens/login/cubit/states.dart';
import 'package:shopping_app/Screens/register/register_screen.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/componnents/constants.dart';
import 'package:shopping_app/shared/network/cashe_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child:
          BlocConsumer<LoginCubit, ShopLoginStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your email ';
                            }
                          },
                          label: 'Email Address',
                          icon: Icons.email_outlined),
                      SizedBox(
                        height: 16,
                      ),
                      defaultTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffixIcon: Icons.visibility,
                          isPassword: LoginCubit.get(context).isPasswordShowen,
                          suffixPressed: () =>
                              LoginCubit.get(context).changePasswordVisiblity(),
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short ';
                            }
                          },
                          onSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          label: 'Password',
                          icon: Icons.password_outlined),
                      SizedBox(
                        height: 32,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isUpperCase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? '),
                          defaultTextButton(
                              text: 'register',
                              function: () =>
                                  navigateTo(context, RegisterScreen()))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status == true) {
            CasheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              showToast(
                  message: state.loginModel.message.toString(),
                  color: Colors.green);
              token = state.loginModel.data!.token.toString();
              navigateAndFinish(context, ShopLayout());
            });
          } else {
            showToast(
                message: state.loginModel.message.toString(),
                color: Colors.red);
          }
        }
      }),
    );
  }
}
