import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/widgets/buttons/circular_button.dart';
import 'package:mobile/core/widgets/headers/header.dart';

class StandardHeader extends Header {
  static const double _headerHeight = 116;

  final String title;
  final VoidCallback? goBack;
  final VoidCallback? action;
  final Icon? actionIcon;

  const StandardHeader({
    super.key,
    super.height = _headerHeight,
    super.hasShadow,
    this.title = '',
    this.goBack,
    this.action,
    this.actionIcon,
  });

  CircularButton _buildGoBackButton() {
    const double buttonSize = 60;

    return CircularButton(
      size: buttonSize,
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: AppColor.primaryColor,
      ),
      onPress: goBack,
    );
  }

  SizedBox _buildLicenseCard() {
    var widthMonitor = Monitor.width;
    double width = widthMonitor / 2;

    return SizedBox(
      width: width,
      child: Text(
        title,
        style: AppText.customStyle(
          color: AppColor.primaryColor,
          fontSize: TextSizes.title2,
        ),
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  CircularButton _buildActionButton(double buttonSize) {
    return CircularButton(size: buttonSize, icon: actionIcon, onPress: action);
  }

  @override
  Widget body(BuildContext context) {
    const double buttonSize = 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildGoBackButton(),
        _buildLicenseCard(),
        if (action != null && actionIcon != null) ...{
          _buildActionButton(buttonSize),
        } else ...{
          SizedBox(height: buttonSize, width: buttonSize),
        },
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(106);
}
