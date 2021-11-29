import 'package:shopping_app/Screens/login/login.dart';
import 'package:shopping_app/shared/componnents/components.dart';
import 'package:shopping_app/shared/network/cashe_helper.dart';

String token = '';
void SignOut(context){
  CasheHelper.removeData(key: 'token').then((value) {
if(value){
  navigateAndFinish(context, LoginScreen());
}

  } );
}