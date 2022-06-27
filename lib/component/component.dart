import 'package:fireb1/component/color.dart';
import 'package:flutter/material.dart';

Widget TextfieldWidget(
        {required TextEditingController controller,
        required TextInputType keyboardType,
        FormFieldValidator? validator,
        required String label,
        String? hint,
        bool? obsecureText,
        bool ispassword = false,
        IconData? prefix,
        IconData? suffixIcon,
        Function? suffixPressed}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: ispassword,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffixIcon))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: kSecondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: kSecondaryColor),
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      ),
    );
