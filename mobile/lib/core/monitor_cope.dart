import 'package:flutter/material.dart';
import 'package:mobile/core/config/monitor.dart';

class MonitorScope extends StatelessWidget {
  final Widget child;

  const MonitorScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mediaQuery = MediaQuery.of(context);
        Monitor.width =
            mediaQuery.orientation == Orientation.landscape
                ? mediaQuery.size.height
                : mediaQuery.size.width;

        Monitor.height =
            mediaQuery.orientation == Orientation.landscape
                ? mediaQuery.size.width
                : mediaQuery.size.height;

        Monitor.orientation = mediaQuery.orientation;

        return child;
      },
    );
  }
}
