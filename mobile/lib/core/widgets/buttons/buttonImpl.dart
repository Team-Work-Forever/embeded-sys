import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/buttons/button.dart';

class ButtonImpl extends Button {
  final Widget child;

  const ButtonImpl({
    super.key,
    super.onPress,
    super.onLongPress,
    required this.child,
  });

  @override
  Widget body(BuildContext context) {
    return child;
  }
}
