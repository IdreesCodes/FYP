import 'package:flutter/material.dart';

import '../../res/color.dart';

class CustomTextField extends StatelessWidget {
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String? hint;
  final bool isfillColorWhite;
  final bool isSecure;
  void Function(String)? onChange;
  final TextEditingController textEditingController;
  TextInputType keyboardType;
  CustomTextField(
      {this.isfillColorWhite = false,
      this.maxLines = 1,
      this.hint,
      required this.textEditingController,
      this.prefixIcon,
      this.suffixIcon,
      this.onChange,
      this.isSecure = false,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: ColorConstants.white,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.042,
        ),
        cursorWidth: 1.5,
        maxLines: maxLines,
        keyboardType: keyboardType,
        cursorHeight: MediaQuery.of(context).size.width * 0.05,
        controller: this.textEditingController,
        obscureText: isSecure,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          fillColor: AppColors.whiteColor,
          filled: true,
          contentPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.045,
            right: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.width * 0.035,
            bottom: MediaQuery.of(context).size.width * 0.035,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.6,
              style: BorderStyle.solid,
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                MediaQuery.of(context).size.width * 0.015,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.6,
              style: BorderStyle.solid,
              color: AppColors.grayColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                MediaQuery.of(context).size.width * 0.015,
              ),
            ),
          ),
          hintText: this.hint,
          hintStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.042,
            color: AppColors.grayColor,
          ),
          prefixIcon: this.prefixIcon,
          suffixIcon: this.suffixIcon,
        ),
        onChanged: onChange,
      ),
    );
  }
}
