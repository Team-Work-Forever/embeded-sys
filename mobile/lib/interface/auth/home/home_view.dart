import 'package:flutter/material.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/widgets/headers/home_header.dart';
import 'package:mobile/interface/auth/home/home_view_model.dart';

final class HomeView extends LinearView<HomeViewModel> {
  const HomeView({super.key, required super.viewModel});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: HomeHeader(
        profile: () => (),
        icon: () => (),
        licensePlate: viewModel.licensePlate,
        hasShadow: false,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Home View"),
            InkWell(
              onTap: () => viewModel.goBack(),
              child: Container(
                height: 40,
                width: 140,
                decoration: BoxDecoration(color: Colors.indigo),
                child: Center(child: Text("Log Out")),
              ),
            ),
            SizedBox(height: 40),
            Text(viewModel.latest?.parkSetId ?? "Waiting for it"),
          ],
        ),
      ),
    );
  }
}
