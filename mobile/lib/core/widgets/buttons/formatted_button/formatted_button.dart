import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/widgets/buttons/formatted_button/formatted_button_type.dart';

class FormattedButton extends StatefulWidget {
  static const double defaultHeight = 46;

  final String content;
  final double height;
  final void Function()? onPress;
  final bool disabled;
  final bool loading;
  final Color? buttonColor;
  final Color textColor;

  const FormattedButton({
    required this.content,
    this.height = defaultHeight,
    this.onPress,
    this.disabled = false,
    this.loading = false,
    super.key,
    this.buttonColor,
    required this.textColor,
  });

  @override
  State<FormattedButton> createState() => _FormattedButtonState();
}

class _FormattedButtonState extends State<FormattedButton> {
  static const double defaultWidth = 247;

  late FormattedButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    buttonType =
        widget.disabled
            ? FormattedButtonType.disabled
            : FormattedButtonType.normal;

    return InkWell(
      borderRadius: AppBoxDecoration.borderRadius10,
      onTap: widget.disabled ? null : widget.onPress,
      child: Container(
        height: widget.height,
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: defaultWidth),
        decoration: BoxDecoration(
          boxShadow: const [AppBoxDecoration.defaultShadow],
          borderRadius: AppBoxDecoration.borderRadius10,
          color: widget.buttonColor ?? buttonType.color,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.loading)
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12, right: 12),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColor.primaryColor,
                      color: Colors.white,
                    ),
                  ),
                ),
              Text(
                widget.loading
                    ? LocaleContext.get()
                        .core_widgets_buttons_formatted_button_loading
                    : widget.content,
                style: TextStyle(
                  fontSize: TextSizes.title3,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
