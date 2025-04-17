import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';

enum FormattedButtonType implements Comparable<FormattedButtonType> {
  normal(color: AppColor.buttonBackground),
  disabled(color: AppColor.disabledButton);

  final Color color;

  const FormattedButtonType({required this.color});

  @override
  int compareTo(FormattedButtonType other) {
    throw UnimplementedError();
  }
}
