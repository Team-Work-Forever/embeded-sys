import 'package:flutter/material.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/providers/matrix_provider.dart';

class MatrixProviderImpl extends ChangeNotifier implements MatrixProvider {
  late int _rows, _cols;
  late int _rowOffset, _colOffset;

  @override
  int get rows => _rows;
  @override
  int get cols => _cols;
  @override
  int get rowOffset => _rowOffset;
  @override
  int get colOffset => _colOffset;

  @override
  Future<void> defineMatrix(List<SectionItem> sections) async {
    final allLots = sections.expand((s) => s.parkingLots);
    if (allLots.isEmpty) {
      _rows = _cols = 0;
      _rowOffset = _colOffset = 0;
      notifyListeners();
      return;
    }

    final minRow = allLots.map((l) => l.row).reduce((a, b) => a < b ? a : b);
    final maxRow = allLots.map((l) => l.row).reduce((a, b) => a > b ? a : b);
    final minCol = allLots.map((l) => l.column).reduce((a, b) => a < b ? a : b);
    final maxCol = allLots.map((l) => l.column).reduce((a, b) => a > b ? a : b);

    _rows = maxRow - minRow + 1;
    _cols = maxCol - minCol + 1;
    _rowOffset = minRow;
    _colOffset = minCol;

    notifyListeners();
  }
}
