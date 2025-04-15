import 'package:flutter/material.dart';
import 'package:mobile/core/config/images.dart';
import 'package:mobile/core/widgets/helpers/svg_image.dart';

class SvgImageBuilder {
  String _path = AppImages.defaultSVG;
  double _height = 20;
  double _width = 20;
  Color? _color;

  VoidCallback? _onPress;
  VoidCallback? _onLongPress;

  SvgImageBuilder setSize(double width, double height) {
    _width = width;
    _height = height;
    return this;
  }

  SvgImageBuilder setColor(Color color) {
    _color = color;
    return this;
  }

  SvgImageBuilder setSvgPath(String path) {
    _path = path;
    return this;
  }

  SvgImageBuilder setOnPress(VoidCallback onPress) {
    _onPress = onPress;
    return this;
  }

  SvgImageBuilder setOnLongPress(VoidCallback onLongPress) {
    _onPress = onLongPress;
    return this;
  }

  SvgImage build() {
    if (_onPress != null || _onLongPress != null) {
      return SvgImage.clickable(
        path: _path,
        height: _height,
        width: _width,
        color: _color,
        onPress: _onPress,
        onLongPress: _onLongPress,
      );
    }

    return SvgImage.base(
      path: _path,
      height: _height,
      width: _width,
      color: _color,
    );
  }
}
