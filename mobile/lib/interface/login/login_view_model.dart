import 'package:flutter/widgets.dart';
import 'package:mobile/core/helpers/form/form_view_model.dart';
import 'package:mobile/services/greet_service/greet_service.dart';
import 'package:mobile/services/proto/greet.pbgrpc.dart';

final class LoginViewModel extends FormViewModel {
  final GreetService _greetService;

  LoginViewModel(this._greetService);

  @override
  Future initAsync() async {
    var response = await _greetService.sayHello(
      HelloRequest(name: "Hello Server!"),
    );

    debugPrint("Hey it responded for real: ${response.message}");
  }
}
