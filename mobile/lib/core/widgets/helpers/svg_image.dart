import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/widgets/buttons/buttonImpl.dart';

class SvgImage extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;

  final String path;

  final VoidCallback? onPress;
  final VoidCallback? onLongPress;

  const SvgImage.base({
    super.key,
    required this.path,
    this.height = 20,
    this.width = 20,
    this.color,
    this.onPress,
    this.onLongPress,
  });

  const SvgImage.clickable({
    Key? key,
    required String path,
    required VoidCallback? onPress,
    required VoidCallback? onLongPress,
    double height = 20,
    double width = 20,
    Color? color,
  }) : this.base(
         key: key,
         path: path,
         height: height,
         width: width,
         color: color,
         onPress: onPress,
         onLongPress: onLongPress,
       );

  FittedBox _buildContent() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SvgPicture.asset(
        path,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        width: width,
        height: height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonImpl(
      onPress: onPress,
      onLongPress: onLongPress,
      child: _buildContent(),
    );
  }
}
