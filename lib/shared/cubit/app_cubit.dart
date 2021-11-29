import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/cubit/app_states.dart';
import 'package:shopping_app/shared/network/cashe_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
   static AppCubit get(context) => BlocProvider.of(context);
     bool isDark = false;
  void changeAppMode({bool? sharedValue}) {
    if (sharedValue != null) {
      isDark = sharedValue;
      emit(ChangeAppThemeState());
    } else {
      isDark = !isDark;
      CasheHelper.saveData(key: 'isDark', value: isDark)
          .then((value) => emit(ChangeAppThemeState()));
    }
  }

  }

