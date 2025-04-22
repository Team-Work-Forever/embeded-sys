import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/images.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/widgets/buttons/circular_button.dart';
import 'package:mobile/core/widgets/headers/home_header.dart';
import 'package:mobile/core/widgets/helpers/svg_image_builder.dart';
import 'package:mobile/core/widgets/layout/interactive_matrix.dart';
import 'package:mobile/core/widgets/layout/list_parking_lot.dart';
import 'package:mobile/core/widgets/modal/modal.dart';
import 'package:mobile/interface/auth/home/home_view_model.dart';

final class HomeView extends LinearView<HomeViewModel> {
  const HomeView({super.key, required super.viewModel});

  Widget _buildList() {
    const double verticalPadding = 26;
    const double horizontalPadding = 16;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: ListParkingLot(sections: viewModel.sections),
      ),
    );
  }

  Widget _buildMatriz() {
    return Positioned.fill(
      child: InteractiveMatrix(
        sections: viewModel.sections,
        rows: viewModel.getNumberRows,
        columns: viewModel.getNumberColumns,
      ),
    );
  }

  Positioned _buildChangeLayoutButton() {
    const double padding = 26;
    const double sizeIcon = 58;
    const double sizeButton = 72;

    return Positioned(
      bottom: padding,
      right: padding,
      child: CircularButton(
        icon: Icon(
          viewModel.isList ? Icons.layers_rounded : Icons.list_rounded,
          color: AppColor.primaryColor,
          size: sizeIcon,
        ),
        onPress: viewModel.changeLayout,
        size: sizeButton,
      ),
    );
  }

  Positioned _buildScheduleButton() {
    const double topPadding = 100;
    const double rightPadding = 12;
    const double sizeIcon = 26;
    const double sizeButton = 48;

    return Positioned(
      bottom: topPadding,
      right: rightPadding,
      child: CircularButton(
        icon: Icon(
          Icons.calendar_month_rounded,
          color: AppColor.primaryColor,
          size: sizeIcon,
        ),
        onPress: () => viewModel.goToSchedule(),
        size: sizeButton,
      ),
    );
  }

  void _checkForFireAndShowModal(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    final hasFire = viewModel.sections.any(
      (section) => section.state == SectionStates.emergency,
    );

    if (hasFire && !viewModel.modalShow) {
      viewModel.changeModalShow();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _buildModal(context, viewModel);
      });
    }

    if (!hasFire) {
      viewModel.changeModalShow();
    }
  }

  void _buildModal(BuildContext context, HomeViewModel viewModel) {
    var modalText = LocaleContext.get().auth_home_section_in_emergency;
    double sizeContent = Monitor.height / 6;

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
        text: LocaleContext.get().modal_confirm,
        onPress: () => Navigator.of(context).pop(),
      ),
      content: Column(
        children: [
          SvgImageBuilder()
              .setSvgPath(AppImages.alertSVG)
              .setSize(sizeContent, sizeContent)
              .build(),
        ],
      ),
      extraButtons: [],
    ).showModalDialog(context);
  }

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    _checkForFireAndShowModal(context, viewModel);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: HomeHeader(
        profileFunc: () => viewModel.goToProfile(),
        iconFunc: () => viewModel.goBack(),
        licensePlate: viewModel.licensePlate,
        hasShadow: false,
      ),
      body: Stack(
        children: [
          SizedBox(width: double.infinity, height: double.infinity),
          (viewModel.isList) ? _buildList() : _buildMatriz(),
          _buildChangeLayoutButton(),
          _buildScheduleButton(),
        ],
      ),
    );
  }
}
