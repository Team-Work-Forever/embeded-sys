import 'package:flutter/material.dart';
import 'package:mobile/core/providers/matrix_provider.dart';

class MatrixProviderImpl extends ChangeNotifier implements MatrixProvider {
  @override
  int get rows => 10;
  int get cols => 10;
}
