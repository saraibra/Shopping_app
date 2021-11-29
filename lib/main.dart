// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/login_model.dart';
import 'package:shopping_app/Screens/Home/ShopCubit/cubit.dart';
import 'package:shopping_app/Screens/Home/shop_layout.dart';
import 'package:shopping_app/Screens/login/login.dart';
import 'package:shopping_app/Screens/on_boarding/on_boarding_screen.dart';
import 'package:shopping_app/shared/cubit/app_cubit.dart';
import 'package:shopping_app/shared/cubit/app_states.dart';
import 'package:shopping_app/shared/network/cashe_helper.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';
import 'package:shopping_app/shared/style/theme.dart';

import 'shared/componnents/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.init();
  DioHelper.init();
  bool onBoarding = CasheHelper.getData(key: 'onBoarding');
   token = CasheHelper.getData(key: 'token');
  bool isDark = CasheHelper.getData(key: 'isDark');
  Widget widget;
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;

  const MyApp({Key key,  this.startWidget, this.isDark})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavouritesData()),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: lightTheme,
              debugShowCheckedModeBanner: false,
              darkTheme: darkTheme,
               themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startWidget,
            );
          },
          listener: (context, state) {}),
    );
  }
}
