import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/inputs/drop_down/drop_down.dart';

class RegularDropDown extends DropDown<String> {
  const RegularDropDown({
    super.key,
    required super.items,
    required super.value,
    required super.onChanged,
  });

  @override
  DropdownMenuItem<String> buildItem(String item) {
    return DropdownMenuItem<String>(value: item, child: Text(item));
  }
}
