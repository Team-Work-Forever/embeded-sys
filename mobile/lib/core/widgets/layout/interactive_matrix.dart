import 'package:flutter/material.dart';
import 'package:mobile/core/errors/invalid_matrix_lot.dart';
import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/widgets/cards/parking_lot.dart';
import 'package:mobile/core/widgets/layout/helpers/layout_helper.dart';

class InteractiveMatrix extends StatefulWidget {
  final int rows;
  final int columns;
  final List<SectionItem> sections;

  const InteractiveMatrix({
    super.key,
    required this.rows,
    required this.columns,
    required this.sections,
  });

  @override
  State<InteractiveMatrix> createState() => _InteractiveMatrixState();
}

class _InteractiveMatrixState extends State<InteractiveMatrix> {
  final double _sizeCards = 40;

  bool verifyIfExistsLot(
    int row,
    int column,
    Map<String, _MappedParkingLotData> map,
  ) {
    final key = '${row}_${column}';
    return map.containsKey(key);
  }

  Map<String, _MappedParkingLotData> _mapParkingLots() {
    final map = <String, _MappedParkingLotData>{};

    try {
      for (
        int sectionIndex = 0;
        sectionIndex < widget.sections.length;
        sectionIndex++
      ) {
        final section = widget.sections[sectionIndex];
        final sectionLabel = LayoutHelper.getSectionLabel(sectionIndex);

        for (var entry in section.parkingLots.asMap().entries) {
          final lot = entry.value;
          final number = entry.key + 1;

          final row = lot.row;
          final column = lot.column;
          if (verifyIfExistsLot(row, column, map)) {
            throw InvalidMatrixLotException();
          }

          final key = '${lot.row}_${lot.column}';
          map[key] = _MappedParkingLotData(
            item: lot,
            sectionLabel: sectionLabel,
            number: number,
          );
        }
      }
    } on InvalidMatrixLotException catch (e) {
      debugPrint(e.toString());
    }

    return map;
  }

  Widget _buildCard(
    int row,
    int col,
    Map<String, _MappedParkingLotData> lotMap,
  ) {
    final key = '${row}_${col}';

    if (lotMap.containsKey(key)) {
      final mapped = lotMap[key]!;
      final item = mapped.item;

      return ParkingLot.matrix(
        myCar: item.myCar,
        number: mapped.number,
        section: mapped.sectionLabel,
        color: item.state.color,
      );
    } else {
      return ParkingLot.matrix(
        myCar: false,
        number: 0,
        section: 'X',
        color: ParkingLotStates.notDefined.color,
      );
    }
  }

  Widget _buildMatrix(
    int rows,
    int columns,
    Map<String, _MappedParkingLotData> lotMap,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rows, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(columns, (col) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: _buildCard(row + 1, col + 1, lotMap),
            );
          }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final map = _mapParkingLots();

    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 1.0,
      boundaryMargin: EdgeInsets.symmetric(
        horizontal: widget.rows * _sizeCards,
        vertical: widget.columns * _sizeCards,
      ),
      constrained: false,
      child: _buildMatrix(widget.rows, widget.columns, map),
    );
  }
}

class _MappedParkingLotData {
  final ParkingLotItem item;
  final String sectionLabel;
  final int number;

  _MappedParkingLotData({
    required this.item,
    required this.sectionLabel,
    required this.number,
  });
}
