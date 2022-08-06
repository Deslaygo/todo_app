import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/themes/color_palette.dart';

class Utils {
  static void showSnackbarError(String titulo, String mensaje) {
    Get.snackbar(
      titulo,
      mensaje,
      messageText: Text(
        mensaje,
        style: const TextStyle(
          fontSize: 18,
          color: backgroundColor,
        ),
      ),
      backgroundColor: errorColor,
      colorText: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 6),
    );
  }

  static InputDecoration getInputDecoration(
          {String label = '', String hintText = '', Widget? suffixIcon}) =>
      InputDecoration(
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: inputColor,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ),
        labelText: label,
        labelStyle: Theme.of(Get.context!).textTheme.bodyText2?.copyWith(
              color: primaryColor,
            ),
      );
}
