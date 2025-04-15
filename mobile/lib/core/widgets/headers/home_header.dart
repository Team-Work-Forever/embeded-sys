import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/images.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/widgets/base/base_card.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';
import 'package:mobile/core/widgets/buttons/circular_button.dart';
import 'package:mobile/core/widgets/headers/header.dart';
import 'package:mobile/core/widgets/helpers/svg_image.dart';
import 'package:mobile/core/widgets/helpers/svg_image_builder.dart';

class HomeHeader extends Header {
  static const double _headerHeight = 116;

  final String licensePlate;
  final VoidCallback? iconFunc;
  final VoidCallback? profileFunc;

  const HomeHeader({
    super.key,
    super.height = _headerHeight,
    super.hasShadow,
    this.licensePlate = '',
    this.iconFunc,
    this.profileFunc,
  });

  SvgImage _buildIcon() {
    const double iconSize = 36;
    const String iconPath = AppImages.iconSVG;

    var svgBuilder = SvgImageBuilder()
        .setSvgPath(iconPath)
        .setSize(iconSize, iconSize);

    if (iconFunc != null) {
      svgBuilder.setOnPress(iconFunc!);
    }

    return svgBuilder.build();
  }

  BaseCard _buildLicenseCard() {
    var widthMonitor = Monitor.width;
    double widthLicenseCard = widthMonitor / 2;
    const double heightLicenseCard = 64;
    return BaseCardBuilder()
        .setSize(widthLicenseCard, heightLicenseCard)
        .setBody(
          Center(
            child: Text(
              licensePlate,
              style: AppText.customStyle(
                color: AppColor.secondaryColor,
                fontSize: TextSizes.title4,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .build();
  }

  CircularButton _buildProfileButton() {
    const double buttonSize = 60;

    return CircularButton(
      size: buttonSize,
      icon: Icon(Icons.person, color: AppColor.primaryColor),
      onPress: profileFunc,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [_buildIcon(), _buildLicenseCard(), _buildProfileButton()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(106);
}
