import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';

final class DialogHelper {
  static void showError(
    BuildContext context,
    String message, {
    TextStyle? textStyle,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              textStyle ??
              AppText.bowlbyOne(
                color: AppColor.widgetBackground,
                fontSize: TextSizes.title6,
              ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? AppColor.strongRed,
      ),
    );
  }
}
