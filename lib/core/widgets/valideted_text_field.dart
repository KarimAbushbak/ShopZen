import 'package:flutter/material.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_font_weight.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';

class ValidatedTextField extends StatefulWidget {
  final String title;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isValid;
  final bool isFocused;
  final bool isTouched;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onFocusChanged;

  const ValidatedTextField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.focusNode,
    required this.isValid,
    required this.isFocused,
    required this.isTouched,
    required this.onChanged,
    required this.onFocusChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  State<ValidatedTextField> createState() => _ValidatedTextFieldState();
}

class _ValidatedTextFieldState extends State<ValidatedTextField> {
  bool _showPassword = false;

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.focusNode.addListener(() {
      widget.onFocusChanged(widget.focusNode.hasFocus);
    });

    Color borderColor;
    if (widget.isFocused) {
      borderColor = Colors.black;
    } else if (widget.isTouched) {
      borderColor = widget.isValid ? Colors.green : Colors.red;
    } else {
      borderColor = Colors.grey;
    }

    Icon? suffixIcon;
    if (widget.isTouched) {
      suffixIcon = widget.isValid
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.error_outline, color: Colors.red);
    }

    Widget? passwordSuffixIcon;
    if (widget.obscureText) {
      passwordSuffixIcon = IconButton(
        icon: Icon(
          _showPassword ? Icons.visibility : Icons.visibility_off,
          color: _showPassword ? Colors.black :Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: ManagerColors.primaryTextColor,
                fontSize: ManagerFontSizes.s16,
                fontWeight: ManagerFontWeight.regular),
          ),
          SizedBox(
            height: ManagerHeight.h4,
          ),
          TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText && !_showPassword,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: widget.obscureText ? passwordSuffixIcon : suffixIcon,
              enabledBorder: _border(borderColor),
              focusedBorder: _border(borderColor),
              errorBorder: _border(Colors.red),
              focusedErrorBorder: _border(Colors.red),
              errorText: !widget.isValid && widget.isTouched
                  ? 'Please enter a valid ${widget.title}'
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
