import 'package:flutter/widgets.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/services/greet_service/greet_service.dart';

final class LoginViewModel extends FormViewModel {
  final GreetService _greetService;

  LoginViewModel(this._greetService);

  @override
  Future initAsync() async {
    debugPrint("Hey it responded for real:");
  }
}
