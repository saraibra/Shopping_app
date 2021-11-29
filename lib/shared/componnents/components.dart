import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/shared/style/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget defaultTextFormField(
        {required TextEditingController controller,
        required TextInputType type,
        onSubmitted,
        onChanged,
        onTab,
        suffixIcon,
        suffixPressed,
        bool isPassword = false,
        required validate,
        required String label,
        required IconData icon}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      validator: validate,
      onTap: onTab,
      obscureText: isPassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            icon,
          ),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffixIcon,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
          )),
    );
Widget defaultButton(
        {required String text,
        required Function function,
        bool isUpperCase = false}) =>
    InkWell(
      onTap: () => function,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
        color: defaultColor
        ),
        child: Center(
          child: Text(
            isUpperCase ? text : text.toUpperCase(),
            style: TextStyle(),
          ),
        ),
      ),
    );
Widget defaultTextButton({required String text, required function}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));
void showToast({required String message, required Color color}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
Widget myDivder() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );

    
   