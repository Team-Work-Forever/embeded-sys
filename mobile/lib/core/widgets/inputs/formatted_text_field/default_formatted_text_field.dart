import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/widgets/inputs/formatted_text_field/formatted_text_field.dart';

class DefaultFormattedTextField extends FormattedTextField {
  const DefaultFormattedTextField({
    super.maxLength,
    super.hintText = '',
    super.isPassword = false,
    super.errorMessage = '',
    super.keyboardType = TextInputType.text,
    super.inputFormatter,
    super.leftIcon,
    super.onChange,
    super.initialValue,
    super.controller,
    super.key,
  });

  @override
  State<DefaultFormattedTextField> createState() =>
      _DefaultFormattedFieldState();
}

class _DefaultFormattedFieldState
    extends FormattedTextFieldState<DefaultFormattedTextField>
    with BaseFormattedTextField {
  @override
  Widget body(BuildContext context) {
    return TextField(
      maxLength: widget.maxLength,
      controller: controller,
      onChanged: widget.onChange,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatter ?? widget.inputFormatter,
      obscureText: widget.isPassword,
      cursorColor: fieldType.focusColor,
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(
          fontSize: TextSizes.title5,
          color: colorizeOnFocus(),
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: getInputBorder(),
        enabledBorder: getInputBorder(),
        suffixIcon: Icon(widget.leftIcon?.icon, color: colorizeOnFocus()),
      ),
    );
  }
}
