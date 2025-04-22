import 'package:mobile/core/models/section_item.dart';

abstract class MatrixProvider {
  int get rows;
  int get cols;
  int get rowOffset;
  int get colOffset;

  Future<void> defineMatrix(List<SectionItem> sections);
}
