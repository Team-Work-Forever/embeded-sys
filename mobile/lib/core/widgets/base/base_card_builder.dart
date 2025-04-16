import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/widgets/base/base_card.dart';

class BaseCardBuilder {
  double? _width;
  double? _height;
  Widget _body = const SizedBox();
  Color _color = AppColor.widgetBackground;
  BorderRadius _borderRadius = AppBoxDecoration.borderRadius5;

  double? _topPadding;
  double? _bottomPadding;
  double? _leftPadding;
  double? _rightPadding;

  double? _symmetricHorizontalPadding;
  double? _symmetricVerticalPadding;

  Border? _border;

  bool _hasShadow = true;
  bool _isCircular = false;

  BaseCardBuilder setSize(double width, double height) {
    _width = width;
    _height = height;
    return this;
  }

  BaseCardBuilder setWidth(double width) {
    _width = width;
    return this;
  }

  BaseCardBuilder setHeight(double height) {
    _height = height;
    return this;
  }

  BaseCardBuilder setBody(Widget body) {
    _body = body;
    return this;
  }

  BaseCardBuilder setColor(Color color) {
    _color = color;
    return this;
  }

  BaseCardBuilder setBorderRadius(BorderRadius borderRadius) {
    _borderRadius = borderRadius;
    return this;
  }

  BaseCardBuilder setBorder(Border border) {
    _border = border;
    return this;
  }

  BaseCardBuilder setPadding(
    double top,
    double bottom,
    double left,
    double right,
  ) {
    _topPadding = top;
    _bottomPadding = bottom;
    _leftPadding = left;
    _rightPadding = right;
    return this;
  }

  BaseCardBuilder setSymmetricPadding(double vertical, double horizontal) {
    _symmetricHorizontalPadding = horizontal;
    _symmetricVerticalPadding = vertical;
    return this;
  }

  BaseCardBuilder hasNotShadow({bool hasShadow = false}) {
    _hasShadow = hasShadow;
    return this;
  }

  BaseCardBuilder hasCircular({bool hasCircular = true}) {
    _isCircular = hasCircular;
    return this;
  }

  BaseCard build() {
    if (_isCircular) {
      return BaseCard.custom(
        width: _width,
        height: _height,
        body: _body,
        color: _color,
        borderRadius: BorderRadius.zero,
        border: _border,
        hasShadow: _hasShadow,
        isCircular: true,
      );
    }

    if (_symmetricHorizontalPadding != null ||
        _symmetricVerticalPadding != null) {
      return BaseCard.symmetric(
        width: _width,
        height: _height,
        body: _body,
        horizontalPadding: _symmetricHorizontalPadding ?? 0,
        verticalPadding: _symmetricVerticalPadding ?? 0,
        color: _color,
        borderRadius: _borderRadius,
        border: _border,
        hasShadow: _hasShadow,
        isCircular: false,
      );
    }

    if ((_topPadding ?? 0) == 0 &&
        (_bottomPadding ?? 0) == 0 &&
        (_leftPadding ?? 0) == 0 &&
        (_rightPadding ?? 0) == 0) {
      return BaseCard.zeroPadding(
        width: _width,
        height: _height,
        body: _body,
        color: _color,
        borderRadius: _borderRadius,
        border: _border,
        hasShadow: _hasShadow,
        isCircular: false,
      );
    }

    return BaseCard.custom(
      width: _width,
      height: _height,
      body: _body,
      color: _color,
      borderRadius: _borderRadius,
      topPadding: _topPadding ?? 0,
      bottomPadding: _bottomPadding ?? 0,
      leftPadding: _leftPadding ?? 0,
      rightPadding: _rightPadding ?? 0,
      border: _border,
      hasShadow: _hasShadow,
      isCircular: false,
    );
  }
}
