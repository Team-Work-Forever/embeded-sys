import 'package:flutter/material.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';

class ReserveCardBuilder {
  late Widget _baseContent;
  Widget? _leftSection;
  Widget? _rightSection;
  bool _hasShadow = true;

  ReserveCardBuilder setBaseContent(Widget content) {
    _baseContent = content;
    return this;
  }

  ReserveCardBuilder setLeftSection(Widget section) {
    _leftSection = section;
    return this;
  }

  ReserveCardBuilder setRightSection(Widget section) {
    _rightSection = section;
    return this;
  }

  ReserveCardBuilder hasShadow(bool value) {
    _hasShadow = value;
    return this;
  }

  Widget build() {
    final width = Monitor.width;
    const height = 88.0;

    return Stack(
      children: [
        BaseCardBuilder()
            .setSize(width, height)
            .hasNotShadow(hasShadow: _hasShadow)
            .setBody(_baseContent)
            .build(),
        if (_leftSection != null) Positioned(left: 0, child: _leftSection!),
        if (_rightSection != null) Positioned(right: 0, child: _rightSection!),
      ],
    );
  }
}
