import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';

abstract class Header extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double paddingHorizontal;
  final double topPadding;
  final double bottomPadding;
  final bool hasShadow;

  Widget body(BuildContext context);

  const Header({
    super.key,
    required this.height,
    this.paddingHorizontal = 16,
    this.topPadding = 48,
    this.bottomPadding = 16,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace:
            BaseCardBuilder()
                .setSize(double.infinity, height)
                .setPadding(
                  topPadding,
                  bottomPadding,
                  paddingHorizontal,
                  paddingHorizontal,
                )
                .setBody(body(context))
                .hasNotShadow(hasShadow: hasShadow)
                .build(),
      ),
    );
  }
}
