import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    this.hintText = '********',
    this.validator,
    this.prefixIcon,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
          onPressed: () => setState(() => _isObscure = !_isObscure),
          icon: Icon(
            _isObscure ? Icons.remove_red_eye : Icons.visibility_off_rounded,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
