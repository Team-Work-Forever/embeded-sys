import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/widgets/base/base_card.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';
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

  BaseCard _buildIdentifier(Color color, double dimension) {
    return BaseCardBuilder()
        .setSize(dimension, dimension)
        .hasCircular()
        .setColor(color)
        .build();
  }

  Widget _buildCaptionItem(
    Widget identifier,
    String description, {
    TextStyle? descriptionStyle,
  }) {
    const double gap = 4;

    return IntrinsicWidth(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: gap,
        children: [
          identifier,
          Text(
            description,
            style:
                descriptionStyle ??
                AppText.customStyle(
                  color: AppColor.secondaryColor,
                  fontSize: TextSizes.title6,
                ),
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCaption(double paddingLine) {
    const double padding = 16;
    const double gap = 12;
    const double dimension = 26;

    return Column(
      spacing: gap,
      children: [
        BaseCardBuilder()
            .setSymmetricPadding(padding, padding)
            .setBody(
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var state in ParkingLotStates.values)
                    _buildCaptionItem(
                      _buildIdentifier(state.color, dimension),
                      state.displayValue,
                    ),
                  _buildCaptionItem(
                    Icon(
                      Icons.directions_car_filled_rounded,
                      color: AppColor.primaryColor,
                      size: dimension,
                    ),
                    LocaleContext.get().auth_home_caption_my_car,
                  ),
                ],
              ),
            )
            .build(),
        Line(width: Monitor.width - paddingLine),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const double gap = 16;
    const double bigGap = 26;
    const double paddingLine = 44;

    return Column(
      spacing: gap,
      children: [
        _buildCaption(paddingLine),
        for (var i = 0; i < sections.length; i++) ...[
          _buildText(i),
          _buildParkingLots(i),
          SizedBox(height: bigGap),
          Line(width: Monitor.width - paddingLine),
        ],
      ],
    );
  }
}
