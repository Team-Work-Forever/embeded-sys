import 'package:flutter/material.dart';

abstract class Button extends StatelessWidget {
  final void Function()? onPress;
  final void Function()? onLongPress;

  const Button({super.key, this.onPress, this.onLongPress});

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      onLongPress: onLongPress,
      child: body(context),
    );
  }
}
