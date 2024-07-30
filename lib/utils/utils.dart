import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lcpl_admin/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
   static Future urlLauncher(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
    static void changeFocus({required FocusNode currentFocus, required FocusNode nextFocus,required BuildContext context}) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
 static   String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
static void toastMessage({required String message}){ Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.greyColor,
        textColor: AppTheme.darkGrey,
        fontSize: 16.0
    );}
 
}