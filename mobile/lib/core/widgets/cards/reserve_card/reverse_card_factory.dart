import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/widgets/cards/reserve_card/reserve_card_builder.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';
import 'package:mobile/core/widgets/buttons/buttonImpl.dart';
import 'package:mobile/core/widgets/modal/modal.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';

class ReserveCardFactory {
  static Widget history({
    required DateTime date,
    required String interval,
    required int duration,
    required String slot,
  }) {
    final width = Monitor.width;
    const height = 88.0;
    final infoWidth = width / 5;

    return ReserveCardBuilder()
        .setBaseContent(_buildBase(interval, '$duration min'))
        .setLeftSection(_buildLeft(infoWidth, height, date))
        .setRightSection(_buildRight(infoWidth, height, slot))
        .build();
  }

  static Widget current({
    required DateTime date,
    required String slot,
    required String time,
  }) {
    final width = Monitor.width;
    const height = 88.0;
    final infoWidth = width / 5;

    return ReserveCardBuilder()
        .hasShadow(false)
        .setBaseContent(_buildCurrentBase(slot))
        .setLeftSection(_buildLeft(infoWidth, height, date))
        .setRightSection(
          _buildRight(
            infoWidth,
            height,
            time,
            background: AppColor.secondaryColor,
            textStyle: AppText.bowlbyOne(
              color: AppColor.widgetBackground,
              fontSize: TextSizes.title5,
            ),
          ),
        )
        .build();
  }

  static Widget cancellable({
    required DateTime date,
    required String time,
    required String slot,
    required BuildContext context,
    required Modal modal,
  }) {
    final width = Monitor.width;
    const height = 88.0;
    final infoWidth = width / 5;

    return ReserveCardBuilder()
        .setBaseContent(
          _buildBase(time, slot, showCalendar: true, hideTimerIcon: true),
        )
        .setLeftSection(_buildLeft(infoWidth, height, date))
        .setRightSection(
          _buildRightButton(infoWidth, height, () {
            modal.showModalDialog(context);
          }),
        )
        .build();
  }

  static Widget _buildBase(
    String top,
    String bottom, {
    bool showCalendar = false,
    bool hideTimerIcon = false,
  }) {
    const double gap = 4;
    const double showCalendarIcon = 20;
    const double showTimeIcon = 16;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showCalendar)
                Icon(
                  Icons.calendar_month_rounded,
                  size: showCalendarIcon,
                  color: AppColor.secondaryColor,
                ),
              if (showCalendar) const SizedBox(width: gap),
              Text(
                top,
                style: AppText.customStyle(
                  color: AppColor.secondaryColor,
                  fontSize: TextSizes.title4,
                ),
              ),
            ],
          ),
          if (bottom.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!hideTimerIcon)
                  Icon(
                    Icons.timer,
                    size: showTimeIcon,
                    color: AppColor.secondaryColor,
                  ),
                if (!hideTimerIcon) const SizedBox(width: gap),
                Text(
                  bottom,
                  style:
                      hideTimerIcon
                          ? AppText.bowlbyOne(
                            color: AppColor.primaryColor,
                            fontSize: TextSizes.title2,
                          )
                          : AppText.customStyle(
                            color: AppColor.secondaryColor,
                            fontSize: TextSizes.title4,
                          ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  static Widget _buildCurrentBase(String slot) {
    return Center(
      child: Text(
        slot,
        style: AppText.bowlbyOne(
          color: AppColor.primaryColor,
          fontSize: TextSizes.title1,
        ),
      ),
    );
  }

  static Widget _buildLeft(double width, double height, DateTime date) {
    return BaseCardBuilder()
        .setSize(width, height)
        .hasNotShadow()
        .setColor(AppColor.buttonBackground)
        .setBorderRadius(
          BorderRadius.only(
            topLeft: AppBoxDecoration.radius5,
            bottomLeft: AppBoxDecoration.radius5,
          ),
        )
        .setBody(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('dd').format(date),
                style: AppText.bowlbyOne(
                  color: AppColor.widgetBackground,
                  fontSize: TextSizes.title2,
                ),
              ),
              Text(
                DateFormat('MMM').format(date),
                style: AppText.bowlbyOne(
                  color: AppColor.widgetBackground,
                  fontSize: TextSizes.title2,
                ),
              ),
            ],
          ),
        )
        .build();
  }

  static Widget _buildRight(
    double width,
    double height,
    String text, {
    Color background = AppColor.primaryColor,
    TextStyle? textStyle,
  }) {
    return BaseCardBuilder()
        .setSize(width, height)
        .hasNotShadow()
        .setColor(background)
        .setBorderRadius(
          BorderRadius.only(
            topRight: AppBoxDecoration.radius5,
            bottomRight: AppBoxDecoration.radius5,
          ),
        )
        .setBody(
          Center(
            child: Text(
              text,
              style:
                  textStyle ??
                  AppText.bowlbyOne(
                    color: AppColor.widgetBackground,
                    fontSize: TextSizes.title2,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        )
        .build();
  }

  static Widget _buildRightButton(
    double width,
    double height,
    VoidCallback onPressed,
  ) {
    return ButtonImpl(
      onPress: onPressed,
      child:
          BaseCardBuilder()
              .setSize(width, height)
              .hasNotShadow()
              .setColor(Colors.transparent)
              .setBorder(Border.all(color: AppColor.occupied, width: 3))
              .setBorderRadius(
                BorderRadius.only(
                  topRight: AppBoxDecoration.radius5,
                  bottomRight: AppBoxDecoration.radius5,
                ),
              )
              .setBody(
                const Icon(
                  Icons.delete_outlined,
                  color: AppColor.occupied,
                  size: 36,
                ),
              )
              .build(),
    );
  }
}
