import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/converters/reserves_converter.dart';
import 'package:mobile/core/helpers/form/form_field_values.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/widgets/buttons/formatted_button/formatted_button.dart';
import 'package:mobile/core/widgets/headers/standard_header.dart';
import 'package:mobile/core/widgets/inputs/date_picker.dart';
import 'package:mobile/core/widgets/layout/interactive_matrix.dart';
import 'package:mobile/core/widgets/modal/modal.dart';
import 'package:mobile/core/widgets/restrictor/line.dart';
import 'package:mobile/interface/auth/schedule/add_reserve/add_reserve_view_model.dart';

final class AddReserveView extends LinearView<AddReserveViewModel> {
  const AddReserveView({super.key, required super.viewModel});

  Modal _buildModal(
    BuildContext context,
    AddReserveViewModel viewModel,
    ParkingLotItem parkLot,
  ) {
    var modalText = LocaleContext.get().add_reserve_confirm_reserve;
    ReserveItem card = ReserveItem(
      id: parkLot.id,
      slotId: parkLot.id,
      date: viewModel.getValue(FormFieldValues.date).value,
      slot: parkLot.slot!,
    );

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
      content: Column(children: [card.toCurrentCard(context)]),
      extraButtons: [
        ButtonOptionItem(
          text: LocaleContext.get().modal_confirm,
          onPress: () async {
            await viewModel.addReserve(card);
            Navigator.of(context).pop();
          },
          backgroundColor: AppColor.buttonBackground,
        ),
      ],
    );
  }

  Widget _buildDate(double horizontalPadding) {
    var contextWidth = Monitor.width - (2 * horizontalPadding);
    const double gap = 12;

    return Column(
      spacing: gap,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: contextWidth,
              child: Column(
                children: [
                  Text(
                    LocaleContext.get().add_reserve_date,
                    style: AppText.customStyle(
                      color: AppColor.primaryColor,
                      fontSize: TextSizes.title3,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    LocaleContext.get().add_reserve_date_description,
                    style: AppText.customStyle(
                      color: AppColor.secondaryColor,
                      fontSize: TextSizes.title4,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        DatePicker(onChanged: (dateTime) => viewModel.setDate(dateTime)),
      ],
    );
  }

  Widget _buildMatrix(
    BuildContext context,
    double horizontalPadding,
    dynamic constraints,
  ) {
    var contextWidth = Monitor.width - (2 * horizontalPadding);
    const double gap = 12;

    return Column(
      spacing: gap,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: contextWidth,
              child: Column(
                children: [
                  Text(
                    LocaleContext.get().add_reserve_parking_lot,
                    style: AppText.customStyle(
                      color: AppColor.primaryColor,
                      fontSize: TextSizes.title3,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    LocaleContext.get().add_reserve_parking_lot_description,
                    style: AppText.customStyle(
                      color: AppColor.secondaryColor,
                      fontSize: TextSizes.title4,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: constraints.maxHeight * 0.4,
          child: InteractiveMatrix(
            rows: viewModel.getNumberRows,
            columns: viewModel.getNumberColumns,
            sections: viewModel.sections,
            onTapLot: (parkLot) => viewModel.setParkLot(parkLot),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, AddReserveViewModel viewModel) {
    const double gap = 26;
    const double verticalPadding = 16;
    const double horizontalPadding = 16;
    double width = Monitor.width;

    FormattedButton buildButton(BuildContext context) {
      return FormattedButton(
        content: LocaleContext.get().modal_confirm,
        onPress:
            () => _buildModal(
              context,
              viewModel,
              viewModel.getValue(FormFieldValues.parkLot).value,
            ).showModalDialog(context),
        textColor: AppColor.widgetBackground,
        disabled: viewModel.thereAreErrors,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
        goBack: () => viewModel.goBack(),
        title: LocaleContext.get().add_reserve_title,
        hasShadow: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  spacing: gap,
                  children: [
                    _buildDate(horizontalPadding),
                    Line(width: width),
                    _buildMatrix(context, horizontalPadding, constraints),
                    buildButton(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
