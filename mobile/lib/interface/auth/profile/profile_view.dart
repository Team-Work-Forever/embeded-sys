import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/helpers/form/form_field_values.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';
import 'package:mobile/core/widgets/restrictor/line.dart';
import 'package:mobile/core/widgets/headers/standard_header.dart';
import 'package:mobile/core/widgets/inputs/drop_down/language_drop_down.dart';
import 'package:mobile/interface/auth/profile/profile_view_model.dart';

final class ProfileView extends LinearView<ProfileViewModel> {
  const ProfileView({super.key, required super.viewModel});

  Column _buildLicensePlate() {
    var widthMonitor = Monitor.width;
    const double heightLicenseCard = 46;
    const double smallGap = 4;
    const double gap = 26;
    const double paddingLine = 44;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleContext.get().auth_login_license_plate,
          style: AppText.customStyle(
            color: AppColor.secondaryColor,
            fontSize: TextSizes.title5,
          ),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: smallGap),
        BaseCardBuilder()
            .setSize(widthMonitor, heightLicenseCard)
            .setBody(
              Center(
                child: Text(
                  viewModel.licensePlate,
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
            .build(),
        SizedBox(height: gap),
        Line(width: widthMonitor - paddingLine),
        SizedBox(height: gap),
      ],
    );
  }

  _buildSelector() {
    const double smallGap = 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleContext.get().language,
          style: AppText.customStyle(
            color: AppColor.secondaryColor,
            fontSize: TextSizes.title5,
          ),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: smallGap),
        LanguageDropDown(
          items: viewModel.getAllLanguages,
          value: viewModel.getValue(FormFieldValues.language).value,
          onChanged: (lang) => viewModel.changeLanguage(lang),
        ),
      ],
    );
  }

  Column _settingsAndPreferences() {
    const double gap = 12;

    return Column(
      children: [
        Text(
          LocaleContext.get().profile_settings_and_preferences,
          style: AppText.customStyle(
            color: AppColor.primaryColor,
            fontSize: TextSizes.title3,
          ),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: gap),
        _buildSelector(),
      ],
    );
  }

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    const double gap = 24;

    const double verticalPadding = 24;
    const double horizontalPadding = 38;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
        action: () => viewModel.goSignOut(),
        actionIcon: Icon(
          Icons.door_front_door_outlined,
          color: AppColor.primaryColor,
        ),
        goBack: () => viewModel.goBack(),
        title: LocaleContext.get().profile_title,
        hasShadow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLicensePlate(),
              SizedBox(height: gap),
              _settingsAndPreferences(),
            ],
          ),
        ),
      ),
    );
  }
}
