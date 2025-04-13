import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';

class BaseCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget body;
  final Color color;
  final BorderRadius borderRadius;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final bool hasShadow;

  const BaseCard.custom({
    super.key,
    required this.width,
    required this.height,
    required this.body,
    this.color = AppColor.widgetBackground,
    this.borderRadius = AppBoxDecoration.borderRadius5,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.hasShadow = true,
  });

  const BaseCard.zeroPadding({
    Key? key,
    required double width,
    required double height,
    required Widget body,
    Color color = AppColor.widgetBackground,
    BorderRadius borderRadius = AppBoxDecoration.borderRadius5,
    hasShadow = true,
  }) : this.custom(
         key: key,
         width: width,
         height: height,
         body: body,
         color: color,
         borderRadius: borderRadius,
       );

  const BaseCard.symmetric({
    Key? key,
    required double width,
    required double height,
    required Widget body,
    double horizontalPadding = 16,
    double verticalPadding = 12,
    Color color = AppColor.widgetBackground,
    BorderRadius borderRadius = AppBoxDecoration.borderRadius5,
    hasShadow = true,
  }) : this.custom(
         key: key,
         width: width,
         height: height,
         body: body,
         color: color,
         borderRadius: borderRadius,
         topPadding: verticalPadding,
         bottomPadding: verticalPadding,
         leftPadding: horizontalPadding,
         rightPadding: horizontalPadding,
       );

  double get effectiveHorizontalPadding =>
      (leftPadding != 0 || rightPadding != 0)
          ? leftPadding + rightPadding
          : 2 * leftPadding;

  double get effectiveVerticalPadding =>
      (topPadding != 0 || bottomPadding != 0)
          ? topPadding + bottomPadding
          : 2 * topPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
        left: leftPadding,
        right: rightPadding,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: hasShadow ? [AppBoxDecoration.defaultShadow] : [],
      ),
      child: SizedBox(
        width: width - effectiveHorizontalPadding,
        height: height - effectiveVerticalPadding,
        child: body,
      ),
    );
  }
}
