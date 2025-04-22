import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/converters/reserves_converter.dart';
import 'package:mobile/core/helpers/grouping_helper.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/widgets/buttons/circular_button.dart';
import 'package:mobile/core/widgets/headers/standard_header.dart';
import 'package:mobile/core/widgets/modal/modal.dart';
import 'package:mobile/core/widgets/restrictor/text_line.dart';
import 'package:mobile/interface/auth/schedule/schedule_view_model.dart';

final class ScheduleView extends LinearView<ScheduleViewModel> {
  const ScheduleView({super.key, required super.viewModel});

  Modal _buildModal(
    BuildContext context,
    ScheduleViewModel viewModel,
    Widget card,
    String id,
  ) {
    var modalText = LocaleContext.get().schedule_cancel_reserve;

    return Modal(
      title: Text(
        modalText,
        style: AppText.customStyle(
          color: AppColor.primaryColor,
          fontSize: TextSizes.title2,
        ),
        maxLines: 6,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      defaultButton: ButtonOptionItem(
        text: LocaleContext.get().modal_cancel,
        onPress: () => Navigator.of(context).pop(),
        backgroundColor: AppColor.widgetBackground,
        textColor: AppColor.primaryColor,
      ),
      content: Column(children: [card]),
      extraButtons: [
        ButtonOptionItem(
          text: LocaleContext.get().modal_confirm,
          onPress: () {
            viewModel.cancelReserve(id);
            Navigator.of(context).pop();
          },
          backgroundColor: AppColor.buttonBackground,
        ),
      ],
    );
  }

  Widget _buildReserves(BuildContext context) {
    const double gap = 12;

    return Column(
      spacing: gap,
      children: [
        TextLine(
          text: LocaleContext.get().schedule_next,
          textStyle: AppText.bowlbyOne(
            color: AppColor.primaryColor,
            fontSize: TextSizes.title2,
          ),
        ),
        for (var reserve in viewModel.reserves) ...[
          reserve.toCard(
            context,
            _buildModal(
              context,
              viewModel,
              reserve.toCurrentCard(context),
              reserve.id,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReservesHistory(BuildContext context) {
    const double gap = 12;

    final grouped = GroupingHelper.groupAndSort<ReserveHistoryItem, int>(
      items: viewModel.historyReserves,
      groupBy: (item) => item.dateBegin.year,
      groupSort: (a, b) => b.compareTo(a),
      itemSort: (a, b) => b.dateBegin.compareTo(a.dateBegin),
    );

    final widgets = <Widget>[];

    grouped.forEach((year, items) {
      widgets.add(
        TextLine(
          text: '$year',
          textStyle: AppText.bowlbyOne(
            color: AppColor.primaryColor,
            fontSize: TextSizes.title2,
          ),
        ),
      );

      widgets.addAll(items.map((item) => item.toCard()));
    });

    return Column(spacing: gap, children: widgets);
  }

  Positioned _buildAddReserveButton() {
    const double paddingVertical = 26;
    const double paddingHorizontal = 16;
    const double sizeIcon = 58;
    const double sizeButton = 72;

    return Positioned(
      bottom: paddingVertical,
      right: paddingHorizontal,
      child: CircularButton(
        icon: Icon(
          Icons.add_circle_outline_rounded,
          color: AppColor.primaryColor,
          size: sizeIcon,
        ),
        onPress: viewModel.addReserve,
        size: sizeButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context, ScheduleViewModel viewModel) {
    const double internalGap = 12;

    const double verticalPadding = 16;
    const double horizontalPadding = 38;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
        goBack: () => viewModel.goBack(),
        title: LocaleContext.get().schedule_title,
        hasShadow: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
              ),
              child: Column(
                spacing: internalGap,
                children: [
                  _buildReserves(context),
                  _buildReservesHistory(context),
                ],
              ),
            ),
          ),
          _buildAddReserveButton(),
        ],
      ),
    );
  }
}
