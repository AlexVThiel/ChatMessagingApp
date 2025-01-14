import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      this.focusNode,
      this.controller,
      this.hintText,
      this.onChanged,
      this.onTap,
      this.isPassword = false,
      this.isChatText = false,
      this.isSearch = false});

  final void Function(String)? onChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final bool isSearch;
  final bool isChatText;
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isChatText ? 35 : null,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        obscureText: isPassword,
        decoration: InputDecoration(
            contentPadding: isChatText ? Constant.paddingSide15 : null,
            filled: true,
            fillColor: isChatText ? white : greyOp12,
            hintText: hintText,
            hintStyle: Constant.size14cCC4,
            suffixIcon: isChatText
                ? InkWell(onTap: onTap, child: const Icon(Icons.send))
                : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isChatText ? 25 : 10),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
