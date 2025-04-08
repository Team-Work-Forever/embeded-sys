import 'package:flutter/material.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/interface/login/login_view_model.dart';

final class LoginView extends LinearView<LoginViewModel> {
  static const String licensePlate = "AB-12-34";
  const LoginView({super.key, required super.viewModel});

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Text("Flutter + Dependency Injection + MVVM + Good Routing!"),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                decoration: BoxDecoration(color: Colors.deepPurple),
                height: 40,
                width: 125,
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap:
                  () async => await viewModel.register(context, licensePlate),
            ),
          ],
        ),
      ),
    );
  }
}
