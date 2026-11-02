// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MainTextFormField extends StatefulWidget {
  MainTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.maxTextLines = 1,
    this.validator,
    required this.ispassword,
    this.colorFill,
    this.label,
    this.prefixIcon,
    this.sufixIcon,
    this.textColor,
    this.textInputNext,
    this.onFieldSubmitted,
  });
  bool ispassword = false;
  String? Function(String?)? validator;
  int maxTextLines;
  String? hint;
  final TextEditingController? controller;
  final Color? colorFill;
  final String? label;
  final String? prefixIcon;
  final String? sufixIcon;
  final Color? textColor;
  final TextInputAction? textInputNext;
  final void Function(String)? onFieldSubmitted;
  @override
  State<MainTextFormField> createState() => _MainTextFormFieldState();
}

class _MainTextFormFieldState extends State<MainTextFormField> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: SizedBox()
    );
  }
}
