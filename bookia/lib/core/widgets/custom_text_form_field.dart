import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.onChange,
    this.textInputAction,
    this.controller,
    this.suffixIcon,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      focusNode: focusNode,
      textInputAction: textInputAction,
      inputFormatters: [
        if (keyboardType == TextInputType.phone) ...[
          LengthLimitingTextInputFormatter(11),
          FilteringTextInputFormatter.digitsOnly,
        ] else if (keyboardType == TextInputType.emailAddress) ...[
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._%+-]')),
        ],
      ],
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },

      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // labelText: 'Email',
      ),
      validator: validator,
      onChanged: onChange,
      onTap: onTap,
    );
  }
}

// [ ...[] , []]
