import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Screens/Home/shop_layout.dart';
import 'package:shopping_app/Screens/register/cubit/register_cubit.dart';
import 'package:shopping_app/Screens/register/cubit/register_states.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/componnents/constants.dart';
import 'package:shopping_app/shared/network/cashe_helper.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, ShopRegisterStates>(
          builder: (context, state) {
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
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your name ';
                            }
                          },
                          label: 'Name',
                          icon: Icons.person),
                      SizedBox(
                        height: 16,
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
                          isPassword:
                              RegisterCubit.get(context).isPasswordShowen,
                          suffixPressed: () => RegisterCubit.get(context)
                              .changePasswordVisiblity(),
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short ';
                            }
                          },
                          onSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          label: 'Password',
                          icon: Icons.password_outlined),
                      SizedBox(
                        height: 16,
                      ),
                      defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone ';
                            }
                          },
                          label: 'Phone',
                          icon: Icons.person),
                      SizedBox(
                        height: 32,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isUpperCase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
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
