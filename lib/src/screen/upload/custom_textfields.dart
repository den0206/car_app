import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    required this.controller,
    required this.labelText,
    this.inputType = TextInputType.text,
    this.isSecure = false,
    this.validator,
    this.onChange,
    this.inputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.onEditingComplete,
    this.focusNode,
    this.inputFormatter,
    this.enable,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final bool isSecure;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  final Function()? onEditingComplete;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final bool? enable;

  final List<TextInputFormatter>? inputFormatter;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusColor: Colors.black,
          border: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: inputType,
      enabled: enable,
      textInputAction: inputAction,
      validator: validator,
      onEditingComplete: onEditingComplete,
      onChanged: onChange,
      obscureText: isSecure,
      inputFormatters: inputFormatter,
    );
  }
}
