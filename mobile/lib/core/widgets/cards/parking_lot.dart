import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/widgets/base/base_card.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';

class ParkingLot extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final bool myCar;
  final int number;
  final String? section;

  const ParkingLot.list({
    super.key,
    required this.myCar,
    required this.number,
    this.height = 20,
    this.width = 20,
    this.color = AppColor.notDefined,
    this.section,
  });

  const ParkingLot.matrix({
    Key? key,
    required bool myCar,
    required int number,
    required String section,
    double height = 20,
    double width = 20,
    Color color = AppColor.notDefined,
  }) : this.list(
         key: key,
         height: height,
         width: width,
         color: color,
         myCar: myCar,
         number: number,
         section: section,
       );

  String _setValueText() {
    if (section == null) {
      return number.toString();
    }

    if (section == 'X') {
      return section!;
    }

    return '$section$number';
  }

  BaseCard _buildBase(double widthMonitor, int number) {
    var sizeCard = widthMonitor / 2.5;

    var card = BaseCardBuilder()
        .setSize(sizeCard, sizeCard)
        .setBody(
          Center(
            child: Text(
              _setValueText(),
              style: AppText.bowlbyOne(
                color:
                    (section == null)
                        ? AppColor.primaryColor
                        : AppColor.subtracted,
                fontSize: TextSizes.title_48,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );

    if (section != null) {
      card.setColor(color);
    }

    return card.build();
  }

  Positioned _buildState(Color color) {
    const double sizeState = 24;

    return Positioned(
      top: 12,
      right: 16,
      child:
          BaseCardBuilder()
              .setSize(sizeState, sizeState)
              .hasCircular()
              .setColor(color)
              .build(),
    );
  }

  Positioned _buildCar(double widthMonitor) {
    var sizeCar = widthMonitor / 14;

    return Positioned(
      bottom: 12,
      right: 16,
      child: Icon(
        Icons.directions_car_filled_rounded,
        color:
            (section == null)
                ? AppColor.primaryColor
                : AppColor.widgetBackground,
        size: sizeCar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var widthMonitor = Monitor.width;

    return Stack(
      children: [
        _buildBase(widthMonitor, number),
        if (section != '') ...{_buildState(color)},
        if (myCar) ...{_buildCar(widthMonitor)},
      ],
    );
  }
}
