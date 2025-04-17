import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';

abstract class DropDown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final void Function(T value)? onChanged;

  const DropDown({super.key, required this.items, this.value, this.onChanged});

  DropdownMenuItem<T> buildItem(T item);

  @override
  State<DropDown<T>> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  late T _value;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    const double heightCard = 48;
    double widthMonitor = Monitor.width;
    const double horizontalPadding = 16;

    return Focus(
      onFocusChange: (value) {
        setState(() {
          isFocused = value;
        });
      },
      child: Container(
        width: widthMonitor,
        decoration: BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: AppBoxDecoration.borderRadius5,
          boxShadow: [AppBoxDecoration.defaultShadow],
        ),
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            itemHeight: heightCard,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColor.secondaryColor,
            ),
            style: AppText.customStyle(
              color: AppColor.secondaryColor,
              fontSize: TextSizes.title4,
            ),
            value: _value,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _value = value;
                });
                widget.onChanged?.call(value);
              }
            },
            items: widget.items.map((item) => widget.buildItem(item)).toList(),
            dropdownColor: AppColor.widgetBackground,
          ),
        ),
      ),
    );
  }
}
