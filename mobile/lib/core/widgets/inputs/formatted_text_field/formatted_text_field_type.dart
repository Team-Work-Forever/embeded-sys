import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';

enum FormattedTextFieldType implements Comparable<FormattedTextFieldType> {
  normal(color: Colors.transparent, focusColor: AppColor.primaryColor),
  error(color: AppColor.error, focusColor: AppColor.error);

  final Color color;
  final Color focusColor;

  const FormattedTextFieldType({required this.color, required this.focusColor});

  @override
  int compareTo(FormattedTextFieldType other) {
    throw UnimplementedError();
  }
}
