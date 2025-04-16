import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/widgets/restrictor/line.dart';
import 'package:mobile/core/widgets/cards/parking_lot.dart';
import 'package:mobile/core/widgets/layout/helpers/layout_helper.dart';

class ListParkingLot extends StatelessWidget {
  final List<SectionItem> sections;

  const ListParkingLot({super.key, required this.sections});

  Row _buildText(int index) {
    const double smallGap = 4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleContext.get().auth_home_section,
          style: AppText.customStyle(
            color: AppColor.primaryColor,
            fontSize: TextSizes.title4,
          ),
        ),
        SizedBox(width: smallGap),
        Text(
          LayoutHelper.getSectionLabel(index),
          style: AppText.bowlbyOne(
            color: AppColor.primaryColor,
            fontSize: TextSizes.title3,
          ),
        ),
      ],
    );
  }

  Wrap _buildParkingLots(int index) {
    const double wrapMargins = 16;

    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: wrapMargins,
      spacing: wrapMargins,
      children: [
        for (var entry in sections[index].parkingLots.asMap().entries) ...[
          ParkingLot.list(
            id: entry.value.id,
            myCar: entry.value.myCar,
            number: entry.key + 1,
            color: entry.value.state.color,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const double gap = 12;
    const double bigGap = 26;
    const double paddingLine = 44;

    return Column(
      children: [
        for (var i = 0; i < sections.length; i++) ...[
          _buildText(i),
          SizedBox(height: gap),
          _buildParkingLots(i),
          SizedBox(height: bigGap),
          Line(width: Monitor.width - paddingLine),
          SizedBox(height: bigGap),
        ],
      ],
    );
  }
}
