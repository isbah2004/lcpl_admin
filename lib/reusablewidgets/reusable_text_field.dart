import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lcpl_admin/reusablewidgets/neomorphism_widget.dart';
import 'package:lcpl_admin/theme/theme.dart';
class ReusableTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? obscureText;
  final FocusNode? focusNode;
  final Widget? prefix, suffix;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const ReusableTextField({super.key, required this.hintText, required this.controller, required this.keyboardType,  this.obscureText,  this.focusNode,  this.prefix,  this.suffix, this.onFieldSubmitted, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeomorphicWidget(
        child: TextFormField(validator: validator,
          controller: controller,style: TextStyle(color:AppTheme.darkGrey),
          keyboardType: keyboardType,
          keyboardAppearance: Brightness.light,
          obscureText: obscureText?? false,
          focusNode: focusNode,
          cursorColor: AppTheme.darkGrey,
          decoration: InputDecoration(hintStyle: GoogleFonts.kanit(),
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: hintText,
            filled: true,
            fillColor: AppTheme.greyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusColor: AppTheme.greyColor,
          ),onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
