import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/helpers/dialog_helpers.dart';
import 'package:mobile/core/locales/locale_context.dart';
import 'package:mobile/core/widgets/base/base_card_builder.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final DateTime? initialDate;

  const DatePicker({super.key, required this.onChanged, this.initialDate});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final maxDate = now.add(const Duration(hours: 48));
    theme(context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          primaryColor: AppColor.primaryColor,
          timePickerTheme: TimePickerThemeData(
            dialHandColor: AppColor.primaryColor,
            entryModeIconColor: AppColor.primaryColor,
            dialBackgroundColor: AppColor.widgetBackground,
          ),
          colorScheme: const ColorScheme.light(
            primary: AppColor.primaryColor,
            onPrimary: AppColor.widgetBackground,
            onSurface: AppColor.primaryColor,
          ),
          dialogTheme: DialogTheme(
            backgroundColor: AppColor.widgetBackground,
            shape: RoundedRectangleBorder(
              borderRadius: AppBoxDecoration.borderRadius5,
            ),
            shadowColor: AppColor.shadowColor,
          ),
        ),
        child: child!,
      );
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selected ?? now,
      firstDate: now,
      lastDate: maxDate,
      barrierColor: AppColor.widgetBackgroundBlurry,
      builder: theme,
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selected ?? now),
      barrierColor: AppColor.widgetBackgroundBlurry,
      builder: theme,
    );

    if (pickedTime == null) return;

    final combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (combined.isAfter(maxDate)) {
      DialogHelper.showError(
        context,
        LocaleContext.get().add_reserve_invalid_date,
      );
      return;
    }

    setState(() => _selected = combined);
    widget.onChanged(combined);
  }

  @override
  Widget build(BuildContext context) {
    final format = 'HH:mm  dd/MM/yyyy';
    final formatted =
        _selected != null
            ? DateFormat(format).format(_selected!)
            : DateFormat(format).format(DateTime.now());

    const double horizontalPadding = 16;
    const double verticalPadding = 12;
    const double height = 46;
    double width = Monitor.width / 1.75;

    return GestureDetector(
      onTap: _pickDateTime,
      child:
          BaseCardBuilder()
              .setSize(width, height)
              .setSymmetricPadding(verticalPadding, horizontalPadding)
              .setBody(
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        formatted,
                        style: AppText.customStyle(
                          color: AppColor.secondaryColor,
                          fontSize: TextSizes.title4,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColor.secondaryColor,
                    ),
                  ],
                ),
              )
              .build(),
    );
  }
}
