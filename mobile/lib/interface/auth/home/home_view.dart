import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/widgets/buttons/circular_button.dart';
import 'package:mobile/core/widgets/headers/home_header.dart';
import 'package:mobile/core/widgets/layout/interactive_matrix.dart';
import 'package:mobile/core/widgets/layout/list_parking_lot.dart';
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
        rows: 10,
        columns: 10,
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
          Icons.list_rounded,
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

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: HomeHeader(
        profileFunc: () => (),
        iconFunc: () => viewModel.goBack(),
        licensePlate: viewModel.licensePlate,
        hasShadow: false,
      ),
      body: Stack(
        children: [
          (viewModel.isList) ? _buildList() : _buildMatriz(),
          _buildChangeLayoutButton(),
          _buildScheduleButton(),
        ],
      ),
    );
  }
}
