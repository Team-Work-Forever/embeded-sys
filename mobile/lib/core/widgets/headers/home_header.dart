import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/images.dart';
import 'package:mobile/core/widgets/base/base_card.dart';
import 'package:mobile/core/widgets/buttons/circular_button.dart';
import 'package:mobile/core/widgets/headers/header.dart';
import 'package:mobile/core/widgets/helpers/svg_image.dart';

class HomeHeader extends Header {
  static const double _headerHeight = 116;
  static const double _iconSize = 36;
  static const double _buttonSize = 60;
  static const String _iconPath = AppImages.iconSVG;

  final String licensePlate;
  final VoidCallback? icon;
  final VoidCallback? profile;

  const HomeHeader({
    super.key,
    super.height = _headerHeight,
    super.hasShadow,
    this.licensePlate = '',
    this.icon,
    this.profile,
  });

  @override
  Widget body(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgImage(path: _iconPath, height: _iconSize, width: _iconSize),
        BaseCard.symmetric(
          width: 180,
          height: 64,
          body: Center(
            child: Text(
              licensePlate,
              style: AppText.customStyle(
                color: AppColor.secondaryColor,
                fontSize: TextSizes.title4,
              ),
            ),
          ),
        ),
        CircularButton(
          size: _buttonSize,
          icon: Icon(Icons.person, color: AppColor.primaryColor),
          onPress: () => (),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
