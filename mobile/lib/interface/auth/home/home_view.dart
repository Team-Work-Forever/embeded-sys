import 'package:flutter/material.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/interface/auth/home/home_view_model.dart';

final class HomeView extends LinearView<HomeViewModel> {
  const HomeView({super.key, required super.viewModel});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [Text("Home View"), Ink(child: Text("Log Out"))],
        ),
      ),
    );
  }
}
