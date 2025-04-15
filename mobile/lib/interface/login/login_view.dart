import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/images.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/formatters/license_plate_formatter.dart';
import 'package:mobile/core/helpers/form/form_field_values.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/widgets/buttons/formatted_button/formatted_button.dart';
import 'package:mobile/core/widgets/helpers/svg_image.dart';
import 'package:mobile/core/widgets/helpers/svg_image_builder.dart';
import 'package:mobile/core/widgets/inputs/formatted_text_field/default_formatted_text_field.dart';
import 'package:mobile/core/widgets/inputs/formatted_text_field/formatted_text_field.dart';
import 'package:mobile/interface/login/login_view_model.dart';

final class LoginView extends LinearView<LoginViewModel> {
  const LoginView({super.key, required super.viewModel});

  SvgImage _buildIcon() {
    const String iconPath = AppImages.iconSVG;
    const double iconSize = 116;

    return SvgImageBuilder()
        .setSvgPath(iconPath)
        .setSize(iconSize, iconSize)
        .build();
  }

  Row _buildTextWelcome(BuildContext context, double horizontalPadding) {
    var contextWidth = Monitor.width - (2 * horizontalPadding);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: contextWidth,
          child: Column(
            children: [
              Text(
                LocaleContext.get().auth_login_welcome,
                style: AppText.customStyle(
                  color: AppColor.primaryColor,
                  fontSize: TextSizes.title3,
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                LocaleContext.get().auth_login_log_in_with_license_plate,
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
    );
  }

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    const double gap = 24;
    const double verticalPadding = 116;
    const double horizontalPadding = 16;

    FormattedTextField buildInputLicensePlate() {
      return DefaultFormattedTextField(
        hintText: LocaleContext.get().auth_login_license_plate,
        inputFormatter: [LicensePlateFormatter()],
        keyboardType: TextInputType.text,
        initialValue: viewModel.getDefault(FormFieldValues.licensePlate),
        onChange: (postalCode) => viewModel.setLicensePlate(postalCode),
        errorMessage: viewModel.getValue(FormFieldValues.licensePlate).error,
      );
    }

    FormattedButton buildLogInButton(BuildContext context) {
      return FormattedButton(
        content: LocaleContext.get().auth_login_log_in,
        onPress: () async => await viewModel.register(context),
        textColor: AppColor.widgetBackground,
        disabled: viewModel.thereAreErrors,
      );
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: Monitor.height - 60),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _buildIcon(),
                      SizedBox(height: gap),
                      _buildTextWelcome(context, horizontalPadding),
                    ],
                  ),
                  buildInputLicensePlate(),
                  buildLogInButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
