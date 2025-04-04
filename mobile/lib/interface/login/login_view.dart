import 'package:flutter/material.dart';
import 'package:mobile/core/view.dart';
import 'package:mobile/core/view_model.dart';
import 'package:mobile/interface/login/login_view_model.dart';

final class LoginView extends LinearView<LoginViewModel> {
  const LoginView({super.key, required super.viewModel});

  @override
  Widget build(BuildContext context, ViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Text("Flutter + Dependency Injection + MVVM + Good Routing!"),
    );
  }
}
