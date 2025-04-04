import 'package:flutter/material.dart';
import 'package:mobile/core/view_model.dart';
import 'package:provider/provider.dart';

class ViewModelProvider<T extends ViewModel> extends StatelessWidget {
  final T viewModel;
  final Widget child;

  const ViewModelProvider({
    required this.viewModel,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => viewModel, child: child);
  }
}
