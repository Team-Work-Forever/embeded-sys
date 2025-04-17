import 'package:flutter/material.dart';
import 'package:mobile/core/value_objetcs/language.dart';
import 'package:mobile/core/widgets/inputs/drop_down/drop_down.dart';

class LanguageDropDown extends DropDown<Language> {
  const LanguageDropDown({
    super.key,
    required super.items,
    required super.value,
    required super.onChanged,
  });

  String _toCountryFlag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }

  @override
  DropdownMenuItem<Language> buildItem(Language item) {
    const double gap = 8;

    return DropdownMenuItem<Language>(
      value: item,
      child: Row(
        children: [
          Text(_toCountryFlag(item.code)),
          SizedBox(width: gap),
          Text(item.displayValue),
        ],
      ),
    );
  }
}
