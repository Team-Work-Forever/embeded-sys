class ReserveItem {
  final String id;
  final String slotId;
  final String slot;
  final DateTime date;

  ReserveItem({
    required this.id,
    required this.slotId,
    required this.slot,
    required this.date,
  });
}

class ReserveHistoryItem {
  final String id;
  final String slotId;
  final String slot;
  final DateTime dateBegin;
  final DateTime dateEnd;

  ReserveHistoryItem({
    required this.id,
    required this.slotId,
    required this.slot,
    required this.dateBegin,
    required this.dateEnd,
  });
}
