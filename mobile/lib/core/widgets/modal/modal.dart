import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/widgets/buttons/formatted_button/formatted_button.dart';

class ButtonOptionItem {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final void Function() onPress;

  ButtonOptionItem({
    required this.text,
    required this.onPress,
    this.textColor = AppColor.widgetBackground,
    this.backgroundColor = AppColor.buttonBackground,
  });
}

class Modal extends StatelessWidget {
  final Text title;
  final ButtonOptionItem defaultButton;
  final List<ButtonOptionItem>? extraButtons;
  final Widget content;

  const Modal({
    super.key,
    required this.title,
    required this.defaultButton,
    required this.content,
    this.extraButtons,
  });

  FormattedButton _buildButton(ButtonOptionItem button) {
    return FormattedButton(
      content: button.text,
      textColor: button.textColor,
      buttonColor: button.backgroundColor,
      onPress: button.onPress,
    );
  }

  void showModalDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppColor.widgetBackgroundBlurry,
      builder: (BuildContext context) {
        return build(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16;
    const double verticalPadding = 64;
    const double smallGap = 6;
    const double actionsPadding = 16;

    return AlertDialog(
      scrollable: true,
      backgroundColor: AppColor.widgetBackground,
      shape: RoundedRectangleBorder(
        borderRadius: AppBoxDecoration.borderRadius10,
      ),
      shadowColor: AppBoxDecoration.defaultShadow.color,
      title: title,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [content]),
      actions: [
        if (extraButtons != null)
          for (var button in extraButtons!) ...[
            _buildButton(button),
            SizedBox(height: smallGap),
          ],
        _buildButton(defaultButton),
      ],
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(
        vertical: actionsPadding,
        horizontal: actionsPadding,
      ),
    );
  }
}
