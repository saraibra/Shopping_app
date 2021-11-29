import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/search_model.dart';
import 'package:shopping_app/Screens/Search/cubit/search_states.dart';
import 'package:shopping_app/shared/componnents/constants.dart';
import 'package:shopping_app/shared/network/dio_helper.dart';
import 'package:shopping_app/shared/network/end_point.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel searchModel = SearchModel();
  void search({required String text}) {
          emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH,
    token: token,
     data: {'text': text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());

    });
  }
}
