import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/helpers/date_helper.dart';
import 'package:mobile/core/models/reserve_item.dart';
import 'package:mobile/core/widgets/cards/reserve_card/reverse_card_factory.dart';
import 'package:mobile/core/widgets/modal/modal.dart';

extension ReserveCardFromReserve on ReserveItem {
  Widget toCard(BuildContext context, Modal modal) {
    return ReserveCardFactory.cancellable(
      date: date,
      time: DateFormat('HH:mm').format(date),
      slot: slot,
      context: context,
      modal: modal,
    );
  }

  Widget toCurrentCard(BuildContext context) {
    return ReserveCardFactory.current(
      date: date,
      time: DateFormat('HH:mm').format(date),
      slot: slot,
    );
  }
}

extension ReserveCardFromHistory on ReserveHistoryItem {
  Widget toCard() {
    return ReserveCardFactory.history(
      date: dateBegin,
      interval: DateHelper.formatInterval(dateBegin, dateEnd),
      duration: DateHelper.calculateDurationInMinutes(dateBegin, dateEnd),
      slot: slot,
    );
  }
}
