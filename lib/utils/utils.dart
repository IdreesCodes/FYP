import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/color.dart';

class Utils {
  static void fieldFocus(
      BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static ToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.primaryTextTextColor,
        textColor: AppColors.whiteColor,
        fontSize: 16);
  }
}
