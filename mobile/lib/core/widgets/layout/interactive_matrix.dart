import 'package:flutter/material.dart';
import 'package:mobile/core/config/global.dart';
import 'package:mobile/core/errors/invalid_matrix_lot.dart';
import 'package:mobile/core/models/parking_lot_item.dart';
import 'package:mobile/core/models/section_item.dart';
import 'package:mobile/core/widgets/cards/parking_lot.dart';
import 'package:mobile/core/widgets/layout/helpers/layout_helper.dart';

class InteractiveMatrix extends StatefulWidget {
  final int rows;
  final int columns;
  final List<SectionItem> sections;
  final void Function(ParkingLotItem card)? onTapLot;
  final Color? onTapColor;

  const InteractiveMatrix({
    super.key,
    required this.rows,
    required this.columns,
    required this.sections,
    this.onTapLot,
    this.onTapColor = AppColor.primaryInfo,
  });

  @override
  State<InteractiveMatrix> createState() => _InteractiveMatrixState();
}

class _InteractiveMatrixState extends State<InteractiveMatrix> {
  final double _sizeCards = 40;
  String? _selectedLotId;

  final TransformationController _transformationController =
      TransformationController();
  final GlobalKey _matrixKey = GlobalKey();
  bool _initialZoomApplied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _applyInitialZoom());
  }

  void _applyInitialZoom() {
    final RenderBox? matrixBox =
        _matrixKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? viewerBox = context.findRenderObject() as RenderBox?;

    if (matrixBox == null || viewerBox == null || !matrixBox.hasSize) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _applyInitialZoom());
      return;
    }

    final matrixSize = matrixBox.size;
    final viewerSize = viewerBox.size;

    final scaleX = viewerSize.width / matrixSize.width;
    final scaleY = viewerSize.height / matrixSize.height;
    final scale = (scaleX < scaleY ? scaleX : scaleY) * 0.9;

    final dx = (viewerSize.width - matrixSize.width * scale) / (2 * scale);
    final dy = (viewerSize.height - matrixSize.height * scale) / (2 * scale);

    _transformationController.value =
        Matrix4.identity()
          ..scale(scale)
          ..translate(dx, dy);

    if (!_initialZoomApplied) {
      setState(() {
        _initialZoomApplied = true;
      });
    }
  }

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

  void _handleTapOnFreeLot(ParkingLotItem lot) {
    setState(() {
      _selectedLotId = lot.id;
    });

    widget.onTapLot?.call(lot);
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
        id: item.id,
        myCar: item.myCar,
        number: mapped.number,
        section: mapped.sectionLabel,
        color:
            item.id == _selectedLotId ? widget.onTapColor! : item.state.color,
        onTap:
            isClickable(item)
                ? () => _handleTapOnFreeLot(
                  ParkingLotItem(
                    id: item.id,
                    slotId: item.slotId,
                    slot: "${mapped.sectionLabel}${mapped.number}",
                    myCar: item.myCar,
                    state: item.state,
                    row: row,
                    column: col,
                  ),
                )
                : null,
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

  bool isClickable(ParkingLotItem item) =>
      item.state == ParkingLotStates.free && widget.onTapLot != null;

  Widget _buildMatrix(
    int rows,
    int columns,
    Map<String, _MappedParkingLotData> lotMap,
  ) {
    return Column(
      key: _matrixKey,
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

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _initialZoomApplied ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !_initialZoomApplied,
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: 0.1,
          maxScale: 1.0,
          boundaryMargin: EdgeInsets.symmetric(
            horizontal: widget.columns * _sizeCards * 3,
            vertical: widget.rows * _sizeCards * 3,
          ),
          constrained: false,
          child: _buildMatrix(widget.rows, widget.columns, map),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
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
