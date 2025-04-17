import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/widgets/buttons/button.dart';
import 'package:mobile/core/widgets/helpers/svg_image.dart';

class CircularButton extends Button {
  final double size;
  final Icon? icon;
  final Color colorBackground;
  final SvgImage? svg;

  const CircularButton({
    super.key,
    required this.icon,
    this.size = 10,
    this.colorBackground = AppColor.widgetBackground,
    super.onPress,
    super.onLongPress,
  }) : svg = null;

  const CircularButton.svg({
    super.key,
    required this.svg,
    this.size = 10,
    this.colorBackground = AppColor.widgetBackground,
    super.onPress,
    super.onLongPress,
  }) : icon = null;

  @override
  Widget body(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorBackground,
        boxShadow: const [AppBoxDecoration.defaultShadow],
      ),
      child: icon ?? svg,
    );
  }
}
