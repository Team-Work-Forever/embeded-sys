import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/widgets/inputs/formatted_text_field/formatted_text_field_type.dart';

abstract class FormattedTextField extends StatefulWidget {
  final int? maxLength;
  final bool isPassword;
  final String hintText;
  final String errorMessage;
  final TextInputType keyboardType;
  final Icon? leftIcon;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChange;
  final String? initialValue;
  final TextEditingController? controller;

  const FormattedTextField({
    this.maxLength,
    this.hintText = '',
    this.isPassword = false,
    this.errorMessage = '',
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.leftIcon,
    this.onChange,
    this.initialValue,
    super.key,
    this.controller,
  });
}

abstract class FormattedTextFieldState<Page extends FormattedTextField>
    extends State<Page> {}

mixin BaseFormattedTextField<Page extends FormattedTextField>
    on FormattedTextFieldState<Page> {
  late TextEditingController controller;
  late FormattedTextFieldType fieldType;
  bool isFocus = false;

  OutlineInputBorder getInputBorder() {
    bool isDefault = isFocus;

    return OutlineInputBorder(
      borderRadius: AppBoxDecoration.borderRadius5,
      borderSide: BorderSide(
        color: isDefault ? fieldType.focusColor : fieldType.color,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    fieldType =
        widget.errorMessage.isNotEmpty
            ? FormattedTextFieldType.error
            : FormattedTextFieldType.normal;

    return Column(
      children: [
        LayoutBuilder(
          builder:
              (context, constraints) => Container(
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  borderRadius: AppBoxDecoration.borderRadius5,
                  color: AppColor.widgetBackground,
                  boxShadow: [AppBoxDecoration.defaultShadow],
                ),
                child: Focus(
                  onFocusChange:
                      (hasFocus) => {
                        setState(() {
                          isFocus = hasFocus;
                        }),
                      },
                  child: body(context),
                ),
              ),
        ),
        if (_isErrorType)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.errorMessage,
                style: TextStyle(color: fieldType.focusColor),
              ),
            ),
          ),
      ],
    );
  }

  Widget body(BuildContext context);

  bool get _isErrorType {
    return fieldType == FormattedTextFieldType.error &&
        widget.errorMessage.isNotEmpty;
  }

  Color colorizeOnFocus() =>
      isFocus ? fieldType.focusColor : AppColor.secondaryColor;
}
