import 'package:flutter/material.dart';

class MyFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? sufixIcon;
  final IconData? prefixIcon;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;

  const MyFormTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    this.keyboardType,
    this.sufixIcon,
    this.prefixIcon,
    this.onTap,
    this.focusNode,
    this.errorMsg,
    this.validator,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        errorText: errorMsg,
        suffixIcon: sufixIcon,
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
