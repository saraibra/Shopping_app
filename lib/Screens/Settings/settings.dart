import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/login_model.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/cubit.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/states.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/componnents/constants.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(builder: (context, state) {
      LoginModel userModel = ShopCubit.get(context).userModel;
      nameController.text = userModel.data!.name.toString();
      emailController.text = userModel.data!.email.toString();
      phoneController.text = userModel.data!.phone.toString();
      return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopUpdateUsersLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    defaultTextFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) return 'Name must be not empty';
                          return null;
                        },
                        label: 'Name',
                        icon: Icons.person),
                    SizedBox(height: 8),
                    defaultTextFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) return 'Email must be not empty';
                          return null;
                        },
                        label: 'Email',
                        icon: Icons.email),
                    SizedBox(height: 8),
                    defaultTextFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) return 'Phone must be not empty';
                          return null;
                        },
                        label: 'Phone',
                        icon: Icons.person),
                    SizedBox(height: 20),
                    defaultButton(
                        text: 'Update',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        }),
                    SizedBox(height: 20),
                    defaultButton(
                        text: 'Logout', function: () => SignOut(context)),
                  ],
                ),
              ),
            );
          });
    }, listener: (context, state) {
      if (state is ShopGetUsersSuccessState) {}
    });
  }
}
